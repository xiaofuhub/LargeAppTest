$PBExportHeader$n_cst_dwsyntax_update_screen.sru
forward
global type n_cst_dwsyntax_update_screen from nonvisualobject
end type
end forward

global type n_cst_dwsyntax_update_screen from nonvisualobject
end type
global n_cst_dwsyntax_update_screen n_cst_dwsyntax_update_screen

forward prototypes
public function integer of_dwsyntax_update_screen ()
public function integer of_setup_painter (u_dw ldw_data)
public function integer of_screen_modify_field ()
public function integer of_execute (string as_sql, string as_title)
end prototypes

public function integer of_dwsyntax_update_screen ();//
n_cst_datastore	lds_dw,lds_data,lds_dataview,lds_properties,lds_report_objects
Long			ll_i,ll_count,ll_ccount,ll_pcount,ll_ocount,ll_dataview,ll_row
Long			ll_profile_viewid,ll_report_id,ll_screen_id
String		ls_syntax
Long			ll_rtn
Int 			j,jj,xx,yy,zz
String		ls_fieldname,ls_text
String		ls_dddwname,ls_datacolumn,ls_displaycolumn,ls_dropdownwidth
String		ls_lookupfield,ls_lookuptype
String		ls_x,ls_y,ls_width,ls_height,ls_weight,ls_itatic,ls_underline,ls_alignment
String		ls_lablex,ls_labley,ls_lablewidth,ls_lableheight,ls_lableweight,ls_lableitatic,ls_lableunderline,ls_lablealignment
String		ls_objects,ls_obj
String		ls_otext,ls_owidth,ls_oheight,ls_ox,ls_oy,ls_oalignment,ls_ounderline,ls_obold,ls_oitatic,ls_otype
Long			ll_object_no
String		ls_sql


lds_dw = Create n_cst_datastore
lds_dw.DataObject = "d_profile_saveto_screen"
lds_dw.SetTransObject(sqlca)
ll_count = lds_dw.Retrieve()


lds_data = Create n_cst_datastore

//---Begin Modified by alfee 02.16.2009---
//lds_dataview=create n_cst_datastore
//lds_dataview.dataobject="d_data_view_update"
//lds_dataview.settransobject(sqlca)
//ll_dataview=lds_dataview.retrieve()
ll_dataview = 1
//---End Modified ------------------------

lds_properties = Create n_cst_datastore
lds_properties.DataObject = "d_sys_report_field_properties_update"
lds_properties.SetTransObject(sqlca)

lds_report_objects = Create n_cst_datastore
lds_report_objects.DataObject = "d_report_objects_update"
lds_report_objects.SetTransObject(sqlca)
//

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update screen properties, Please stand by'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update screen properties, Please stand by!'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_count)

FOR ll_i = 1 To ll_count
	//
	IF IsValid(w_infodisp) THEN
		Yield()
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Update ' + String(ll_i) + ' of ' + String(ll_count)+' Please stand by!'
	END IF
	
	ll_profile_viewid = lds_dw.GetItemNumber(ll_i,"profile_view_id")
	ll_report_id = lds_dw.GetItemNumber(ll_i,"profile_report_id")
	ll_screen_id = lds_dw.GetItemNumber(ll_i,"screen_id")
	ls_syntax = of_get_profile_screen_syntax(ll_profile_viewid,ll_report_id)
	lds_data.Reset()
	ll_rtn = lds_data.Create(ls_syntax)
	lds_data.InsertRow(0)
	IF ll_rtn <> 1 THEN
		MessageBox("error:","create datawindow faile!")
	ELSE
		//
		ll_ccount = Long(lds_data.Describe("datawindow.column.count"))
		lds_properties.Retrieve(ll_profile_viewid,ll_screen_id,'S')
		FOR j = 1 To ll_ccount
			ls_fieldname = lds_data.Describe("#"+String(j)+".name")
			ls_x = lds_data.Describe( ls_fieldname + ".x" )
			ls_y = lds_data.Describe( ls_fieldname + ".y" )
			ls_width = lds_data.Describe( ls_fieldname + ".width" )
			ls_height = lds_data.Describe( ls_fieldname + ".height" )
			ls_weight = lds_data.Describe( ls_fieldname + ".font.weight" )
			ls_itatic = lds_data.Describe( ls_fieldname + ".font.italic" )
			ls_underline = lds_data.Describe( ls_fieldname + ".font.underline" )
			ls_alignment = lds_data.Describe( ls_fieldname + ".alignment" )
			ls_text = lds_data.Describe( ls_fieldname + "_t.text" )
			//lable
			ls_lablex = lds_data.Describe( ls_fieldname + "_t.x" )
			ls_labley = lds_data.Describe( ls_fieldname + "_t.y" )
			ls_lablewidth = lds_data.Describe( ls_fieldname + "_t.width" )
			ls_lableweight = lds_data.Describe( ls_fieldname + "_t.font.weight" )
			ls_lableitatic = lds_data.Describe( ls_fieldname + "_t.font.italic" )
			ls_lableunderline = lds_data.Describe( ls_fieldname + "_t.font.underline" )
			ls_lablealignment = lds_data.Describe( ls_fieldname + "_t.alignment" )
			
			lds_properties.SetFilter("sys_report_fields_field_name='"+ls_fieldname+"'")
			lds_properties.Filter()
			ll_pcount = lds_properties.RowCount()
			FOR xx = 1 To ll_pcount
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_field_x",primary!,True) <> Long(ls_x) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_x",Long(ls_x))
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_field_y",primary!,True) <> Long(ls_y) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_y",Long(ls_y))
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_field_width",primary!,True) <> Long(ls_width) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_width",Long(ls_width))
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_field_height",primary!,True) <> Long(ls_height) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_height",Long(ls_height))
				IF lds_properties.GetItemString(xx,"data_view_report_fields_justification",primary!,True) <> ls_alignment THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_justification",ls_alignment)
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_font_wieght",primary!,True) <> Long(ls_weight) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_font_wieght",Long(ls_weight))
				IF lds_properties.GetItemString(xx,"data_view_report_fields_field_underline",primary!,True) <> ls_underline THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_underline",ls_underline)
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_field_font_italic",primary!,True) <> Long(ls_itatic) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_font_italic",Long(ls_itatic))
				IF lds_properties.GetItemString(xx,"data_view_report_fields_field_label",primary!,True) <> ls_text THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_label",ls_text)
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_field_label_x",primary!,True) <> Long(ls_lablex) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_label_x",Long(ls_lablex))
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_field_label_y",primary!,True) <> Long(ls_labley) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_label_y",Long(ls_labley))
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_field_label_width",primary!,True) <> Long(ls_lablewidth) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_field_label_width",Long(ls_lablewidth))
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_label_justification",primary!,True) <> Long(ls_lablealignment) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_label_justification",Long(ls_lablealignment))
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_label_font_weight",primary!,True) <> Long(ls_lableweight) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_label_font_weight",Long(ls_lableweight))
				IF lds_properties.GetItemString(xx,"data_view_report_fields_label_underline",primary!,True) <> ls_lableunderline THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_label_underline",ls_lableunderline)
				IF lds_properties.GetItemNumber(xx,"data_view_report_fields_label_font_italic",primary!,True) <> Long(ls_lableitatic) THEN jj++
				lds_properties.SetItem(xx, "data_view_report_fields_label_font_italic",Long(ls_lableitatic))
				//
				IF lds_properties.GetItemString(xx, "sys_report_fields_lookup_field" ) = 'Y' THEN jj++
				
				IF jj > 0 THEN
					lds_properties.SetItem(xx, "ismodify", '1' )
					jj = 0
				END IF
			NEXT
		NEXT
		//data_view_report_objects
		lds_report_objects.Retrieve(ll_profile_viewid,ll_screen_id,'S')
		
		SELECT Max(data_view_report_objects.data_view_object_id)
			INTO :ll_object_no
			From data_view_report_objects;
		IF IsNull(ll_object_no) THEN ll_object_no = 0
		
		ls_objects = lds_data.Describe("datawindow.objects")+'~t'
		ls_obj = LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
		DO WHILE LenA(ls_obj) > 0
			IF LeftA(ls_obj,6) = "object" And (lds_data.Describe(ls_obj+".type") = "text" Or lds_data.Describe(ls_obj+".type") = "groupbox") THEN
				ls_otext = lds_data.Describe(ls_obj+".text")
				ls_ox = lds_data.Describe(ls_obj+".x")
				ls_oy = lds_data.Describe(ls_obj+".y")
				ls_owidth = lds_data.Describe(ls_obj+".width")
				ls_oheight = lds_data.Describe(ls_obj+".height")
				ls_oalignment = lds_data.Describe(ls_obj+".alignment")
				ls_oitatic = lds_data.Describe(ls_obj+".font.italic")
				ls_obold = lds_data.Describe(ls_obj+".font.weight")
				ls_ounderline = lds_data.Describe(ls_obj+".font.underline")
				ls_otype = lds_data.Describe(ls_obj+".type")
				IF ls_otype = "text" THEN
					ls_otype = 'T'
				ELSE
					ls_otype = 'B'
				END IF
				//
				lds_report_objects.SetFilter("trim(object_text) = '"+Trim(ls_otext)+"'")
				lds_report_objects.Filter()
				ll_ocount = lds_report_objects.RowCount()
				IF ll_ocount > 0 THEN
					FOR zz = 1 To ll_ocount
						lds_report_objects.SetItem(zz, "object_x", Long(ls_ox))
						lds_report_objects.SetItem(zz, "object_y", Long(ls_oy))
						lds_report_objects.SetItem(zz, "object_width", Long(ls_owidth))
						lds_report_objects.SetItem(zz, "object_height", Long(ls_oheight))
						lds_report_objects.SetItem(zz, "object_alignment", Long(ls_oalignment))
						lds_report_objects.SetItem(zz, "object_italic", Long(ls_oitatic))
						lds_report_objects.SetItem(zz, "object_bold", Long(ls_obold))
						lds_report_objects.SetItem(zz, "object_underline", Long(ls_ounderline))
					NEXT
				ELSE
					FOR yy = 1 To ll_dataview
						ll_row = lds_report_objects.InsertRow(0)
						ll_object_no ++
						lds_report_objects.SetItem(ll_row, "data_view_object_id", ll_object_no)
						lds_report_objects.SetItem(ll_row, "data_view_id", yy )
						lds_report_objects.SetItem(ll_row, "screen_id", ll_screen_id)
						lds_report_objects.SetItem(ll_row, "object_type", ls_otype)
						lds_report_objects.SetItem(ll_row, "object_x", Long(ls_ox))
						lds_report_objects.SetItem(ll_row, "object_y", Long(ls_oy))
						lds_report_objects.SetItem(ll_row, "object_width", Long(ls_owidth))
						lds_report_objects.SetItem(ll_row, "object_height", Long(ls_oheight))
						lds_report_objects.SetItem(ll_row, "object_text", ls_otext)
						lds_report_objects.SetItem(ll_row, "object_alignment", Long(ls_oalignment))
						lds_report_objects.SetItem(ll_row, "object_italic", Long(ls_oitatic))
						lds_report_objects.SetItem(ll_row, "object_bold", Long(ls_obold))
						lds_report_objects.SetItem(ll_row, "object_underline", Long(ls_ounderline))
						lds_report_objects.SetItem(ll_row, "report_from", "S")
						lds_report_objects.SetItem(ll_row, "profile_view_id", ll_profile_viewid)
					NEXT
				END IF
			END IF
			ls_objects = MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
			ls_obj = LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
		LOOP
		//
		IF lds_properties.Update() <> 1 THEN MessageBox("error:","The table data_view_report_fields update failed!")
		IF lds_report_objects.Update() <> 1 THEN	MessageBox("error:","The table data_view_report_objects update failed!")
		//
		//		update profile_report_dw set cur_dw=scr_dw where profile_view_id=:ll_profile_viewid and scr_id=:ll_screen_id;
		//		if sqlca.sqlcode<>0 then messagebox("error:","Update profile_report_dw faile!")
		//Modified by Alan on 2008-10-23
		//----------Begin Modified by Alfee on 02.16.2009 -------------------------------------------------
		//<$Reason>Update only while the screen is selected in the profile view
		//ls_sql="update profile_report_dw set cur_dw=scr_dw where profile_view_id="+string(ll_profile_viewid)+" and scr_id="+string(ll_screen_id)
		ls_sql = "update profile_report_dw set cur_dw=scr_dw where profile_view_id="+String(ll_profile_viewid)+" and scr_id="+String(ll_screen_id) + " " + &
			"	and exists (select * from  profile_view_reports, profile_report_dw " + &
			"				   where profile_report_dw.profile_view_id = profile_view_reports.profile_view_id " + &
			"	   			  and profile_report_dw.prf_id = profile_view_reports.profile_report_id	" + &
			"				     and profile_report_dw.scr_id = " + String(ll_screen_id) + " " + &
			"				     and profile_report_dw.profile_view_id = " + String(ll_profile_viewid) + " )"
		//----------End Modified ---------------------------------------------------------------------------
		of_execute(ls_sql,"of_dwsyntax_update_screen")
	END IF
NEXT
//--------Begin Added by Nova 09.18.2008------------------------
Destroy lds_dw
Destroy lds_data
Destroy lds_dataview
Destroy lds_properties
Destroy lds_report_objects
//--------End Added --------------------------------------------------

IF IsValid(w_infodisp) THEN Close(w_infodisp)



RETURN 0

end function

public function integer of_setup_painter (u_dw ldw_data);
Integer i
Integer li_col_cnt
Integer li_sys_col_cnt
Integer li_dv_col_cnt
String ls_col_name
String ls_sys_cols
String ls_data_view_cols
String ls_sys_report_fields_update[]
String ls_dv_fields_update[]
String  ls_sys_key_cols[ ] = {"sys_report_fields_table_id", "sys_report_fields_field_id"}
String  ls_dv_key_cols[ ] = {"data_view_report_fields_data_view_id", "data_view_report_fields_screen_id", "data_view_report_fields_field_id","data_view_report_fields_profile_view_id"}



ldw_data.of_SetMultiTable(TRUE)

ldw_data.of_SetUpdateable(True)

li_col_cnt = Integer( ldw_data.Object.DataWindow.Column.Count )
FOR i = 1 TO li_col_cnt
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04/01/2008 By: Ken.Guo
	//$<reason> If column is invisible or taborder is 0, It can't get column name use this way.
	/*
	ldw_data.SetColumn( i )
	ls_col_name = ldw_data.GetColumnName()
	*/
	ls_col_name = ldw_data.Describe("#"+String(i)+".name") 
	//---------------------------- APPEON END ----------------------------
	IF Upper(MidA(ls_col_name, 1, 17 )) = "SYS_REPORT_FIELDS"  THEN
		li_sys_col_cnt ++
		ls_sys_report_fields_update[li_sys_col_cnt] = ls_col_name
	ELSEIF Upper(MidA(ls_col_name, 1, 23 )) = "data_view_report_fields" THEN
		li_dv_col_cnt ++
		ls_dv_fields_update[li_dv_col_cnt] = ls_col_name
	END IF
	
END FOR

li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_label_y"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_label_x"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_label_width"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_x"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_y"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_width"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_height"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_justification"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_font_wieght"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_underline"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_font_italic"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_label"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_visible"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_label_justification"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_label_font_italic"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_label_underline"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_label_font_weight"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "ismodify"

ldw_data.inv_multitable.of_Register( "sys_report_fields", ls_sys_key_cols , ls_sys_report_fields_update, TRUE, 0)
ldw_data.inv_multitable.of_Register( "data_view_report_fields", ls_dv_key_cols , ls_dv_fields_update, TRUE, 0)


Return 0



end function

public function integer of_screen_modify_field ();//Copy and modify fields' properties for these profile saved screens in v8.1

//-----Beign Modified by Alfee 02.16.2009-------------------------
Long ll_i, ll_j, ll_count 
Long ll_prfview_id, ll_screen_id[], ll_null[]
Long ll_prf_ids [] //alfee 12.30.2014

n_cst_datastore lds_prfview, lds_screen
pfc_cst_nv_profile_report_functions lnv_profile_report

lds_prfview = Create n_cst_datastore
lds_screen = Create n_cst_datastore
lnv_profile_report = Create pfc_cst_nv_profile_report_functions

lds_prfview.dataobject="d_profile_saveto_prfview" //profile view id
lds_prfview.settransobject(sqlca)
lds_screen.dataobject="d_profile_saveto_screen"  //profile view id and screen id
lds_screen.settransobject(sqlca)

ll_count=lds_prfview.retrieve()
lds_screen.retrieve()

IF ll_count > 0 THEN
	IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
	IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update field properties, Please stand by'
	IF IsValid(w_infodisp) THEN w_infodisp.Center = True
	IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update field properties, Please stand by!'
	IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_count)
END IF

FOR ll_i = 1 TO ll_count
	IF IsValid(w_infodisp) THEN
		Yield()
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Update ' + String(ll_i) + ' of ' + String(ll_count)+' Please stand by!'
	END IF
	
	ll_prfview_id = lds_prfview.GetItemNumber(ll_i, "profile_view_id")	
	lds_screen.SetFilter("profile_view_id = " + String(ll_prfview_id))
	lds_screen.Filter()
	
	FOR ll_j = 1 to lds_screen.RowCount()
		ll_screen_id[ll_j] = lds_screen.GetItemNumber(ll_j, "screen_id")	
		ll_prf_ids[ll_j] = lds_screen.GetItemNumber(ll_j, "profile_report_id")	//alfee 12.30.2014
	NEXT

	//Copy and modified screen properties from data entry screen
	IF UpperBound(ll_screen_id) > 0 THEN 
		//IF lnv_profile_report.of_copy_screen_properties( ll_prfview_id, 1, ll_screen_id ) < 0 THEN
		IF lnv_profile_report.of_copy_screen_properties( ll_prfview_id, 1, ll_screen_id, ll_prf_ids) < 0 THEN //alfee 12.30.2014
			IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('lnv_profile_report.of_copy_screen_properties('+ String(ll_prfview_id) + ',1,screen_id[])', 'Update screen field properties failed!','Update field properties ')
			gb_upgrade_failed = True
		END IF
	END IF	
	ll_screen_id = ll_null
NEXT

Destroy lds_prfview
Destroy lds_screen
Destroy lnv_profile_report

IF IsValid(w_infodisp) THEN close(w_infodisp)

RETURN 0

/* 
n_cst_datastore	lds_dw,lds_data,lds_dataview,lds_properties,lds_report_objects
long			ll_i,ll_count,ll_ccount,ll_pcount,ll_ocount,ll_dataview,ll_row
long			ll_profile_viewid,ll_report_id,ll_screen_id
string		ls_syntax
long			ll_rtn
int 			j,jj,xx,yy,zz
string		ls_fieldname,ls_text
string		ls_dddwname,ls_datacolumn,ls_displaycolumn,ls_dropdownwidth
string		ls_lookupfield,ls_lookuptype
string		ls_x,ls_y,ls_width,ls_height,ls_weight,ls_itatic,ls_underline,ls_alignment
string		ls_lablex,ls_labley,ls_lablewidth,ls_lableheight,ls_lableweight,ls_lableitatic,ls_lableunderline,ls_lablealignment
string		ls_objects,ls_obj
string		ls_otext,ls_owidth,ls_oheight,ls_ox,ls_oy,ls_oalignment,ls_ounderline,ls_obold,ls_oitatic,ls_otype
long			ll_object_no
string		ls_dataobject


lds_dw=create n_cst_datastore
lds_dw.dataobject="d_screen_dw_orig"
lds_dw.settransobject(sqlca)
ll_count=lds_dw.retrieve()

lds_data=create n_cst_datastore

lds_properties=create n_cst_datastore
lds_properties.dataobject="d_sys_report_field_properties_mupdate"
lds_properties.settransobject(sqlca)




//
IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update screen properties, Please stand by'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update screen properties, Please stand by!'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_count)

for ll_i=1 to ll_count
	//
	IF IsValid(w_infodisp) THEN
		Yield()
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Update ' + String(ll_i) + ' of ' + String(ll_count)+' Please stand by!'
	END IF
	
	ls_dataobject=lds_dw.getitemstring(ll_i,"scr_dw")
	ll_screen_id=lds_dw.getitemnumber(ll_i,'scr_id')
	lds_data.dataobject=ls_dataobject
	lds_data.insertrow(0)
	//
	ll_ccount=long(lds_data.describe("datawindow.column.count"))
	lds_properties.retrieve(ll_screen_id,'S')
	for j=1 to ll_ccount
		ls_fieldname=lds_data.describe("#"+string(j)+".name")
		ls_x=lds_data.Describe( ls_fieldname + ".x" )
		ls_y=lds_data.Describe( ls_fieldname + ".y" )
		ls_width=lds_data.Describe( ls_fieldname + ".width" )
		ls_height=lds_data.Describe( ls_fieldname + ".height" )
		ls_weight=lds_data.Describe( ls_fieldname + ".font.weight" )
		ls_itatic=lds_data.Describe( ls_fieldname + ".font.italic" )			
		ls_underline=lds_data.Describe( ls_fieldname + ".font.underline" )			
		ls_alignment=lds_data.Describe( ls_fieldname + ".alignment" )			
		ls_text=lds_data.Describe( ls_fieldname + "_t.text" )			
		//lable
		ls_lablex=lds_data.Describe( ls_fieldname + "_t.x" )
		ls_labley=lds_data.Describe( ls_fieldname + "_t.y" )
		ls_lablewidth=lds_data.Describe( ls_fieldname + "_t.width" )
		ls_lableweight=lds_data.Describe( ls_fieldname + "_t.font.weight" )
		ls_lableitatic=lds_data.Describe( ls_fieldname + "_t.font.italic" )			
		ls_lableunderline=lds_data.Describe( ls_fieldname + "_t.font.underline" )			
		ls_lablealignment=lds_data.Describe( ls_fieldname + "_t.alignment" )			
		
		lds_properties.setfilter("sys_report_fields_field_name='"+ls_fieldname+"'")
		lds_properties.filter()
		ll_pcount=lds_properties.rowcount()
		for xx=1 to ll_pcount
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_field_x",primary!,true)<>long(ls_x) then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_field_y",primary!,true)<>long(ls_y) then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_field_width",primary!,true)<>long(ls_width) then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_field_height",primary!,true)<>long(ls_height) then jj++
			if lds_properties.GetItemString(xx,"data_view_report_fields_justification",primary!,true)<>ls_alignment then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_font_wieght",primary!,true)<>long(ls_weight) then jj++
			if lds_properties.GetItemString(xx,"data_view_report_fields_field_underline",primary!,true)<>ls_underline then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_field_font_italic",primary!,true)<>long(ls_itatic) then jj++
			if lds_properties.GetItemString(xx,"data_view_report_fields_field_label",primary!,true)<>ls_text then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_field_label_x",primary!,true)<>long(ls_lablex) then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_field_label_y",primary!,true)<>long(ls_labley) then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_field_label_width",primary!,true)<>long(ls_lablewidth) then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_label_justification",primary!,true)<>long(ls_lablealignment) then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_label_font_weight",primary!,true)<>long(ls_lableweight) then jj++
			if lds_properties.GetItemString(xx,"data_view_report_fields_label_underline",primary!,true)<>ls_lableunderline then jj++
			if lds_properties.GetItemNumber(xx,"data_view_report_fields_label_font_italic",primary!,true)<>long(ls_lableitatic) then jj++
			//
			if lds_properties.GetItemString(xx, "sys_report_fields_lookup_field" )='Y' then jj++
			if jj>0 then 
				lds_properties.SetItem(xx, "ismodify", '1' )	
				jj=0
			end if
		next
	next
	//
	if lds_properties.update()<>1 then messagebox("error:","The table data_view_report_fields update failed!")
next

DESTROY lds_dw
DESTROY lds_data
DESTROY lds_properties


IF IsValid(w_infodisp) THEN close(w_infodisp)

return 0
*/
//-------End Modified ---------------------------------------------


end function

public function integer of_execute (string as_sql, string as_title);Yield()

EXECUTE Immediate :as_sql Using Sqlca;
IF Sqlca.SQLCode <> 0 THEN
	
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(as_sql, Sqlca.SQLErrText,as_title)
	gb_upgrade_failed = TRUE
	RETURN -1
END IF
//IF Sqlca.AutoCommit = False THEN
	COMMIT Using Sqlca;
//END IF


RETURN 1
end function

on n_cst_dwsyntax_update_screen.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwsyntax_update_screen.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

