$PBExportHeader$pfc_cst_nv_profile_report_functions.sru
forward
global type pfc_cst_nv_profile_report_functions from nonvisualobject
end type
end forward

global type pfc_cst_nv_profile_report_functions from nonvisualobject
end type
global pfc_cst_nv_profile_report_functions pfc_cst_nv_profile_report_functions

forward prototypes
public function integer of_set_field_modified (integer ai_prf_view_id, integer ai_screen_id[])
public function integer of_add_screen2view (integer ai_profile_view_id, integer ai_profile_report_ids[])
public function integer of_delete_screen_properties (integer ai_prf_view_id, integer ai_screen_id[], string as_report_from)
public function integer of_copy_screen_properties (integer ai_prf_view_id, integer ai_data_view_id, integer ai_screen_ids[], integer ai_prf_ids[])
end prototypes

public function integer of_set_field_modified (integer ai_prf_view_id, integer ai_screen_id[]);//Set ismodified field in table of data_view_report_fields by comparing the values of 
//field properties in DB and that in screen physical datawindow. 
//Called after adding fields' properties in data_view_report_fields for new data entry screens. 
//Moved and modified from n_cst_dwsyntax_update_screen.of_screen_modify_field() 
//By Alfee 02.16.2009

int 			j,jj,xx,yy,zz
long			ll_i,ll_count,ll_ccount,ll_pcount,ll_ocount,ll_dataview,ll_row
long			ll_profile_viewid,ll_report_id,ll_screen_id
long			ll_rtn
long			ll_object_no
string		ls_syntax
string		ls_fieldname,ls_text
string		ls_dddwname,ls_datacolumn,ls_displaycolumn,ls_dropdownwidth
string		ls_lookupfield,ls_lookuptype
string		ls_x,ls_y,ls_width,ls_height,ls_weight,ls_itatic,ls_underline,ls_alignment
string		ls_lablex,ls_labley,ls_lablewidth,ls_lableheight,ls_lableweight,ls_lableitatic,ls_lableunderline,ls_lablealignment
string		ls_objects,ls_obj
string		ls_otext,ls_owidth,ls_oheight,ls_ox,ls_oy,ls_oalignment,ls_ounderline,ls_obold,ls_oitatic,ls_otype
string		ls_dataobject

n_cst_datastore lds_dw,lds_data, lds_properties

lds_dw=create n_cst_datastore
lds_data=create n_cst_datastore
lds_properties=create n_cst_datastore

lds_dw.dataobject="d_profile_report_dw_prfscr"
lds_dw.settransobject(sqlca)
lds_properties.dataobject="d_sys_report_field_properties_update"
lds_properties.settransobject(sqlca)

ll_count=lds_dw.retrieve(ai_prf_view_id, ai_screen_id)

for ll_i=1 to ll_count
	ls_dataobject= lds_dw.getitemstring(ll_i,"scr_dw")
	ll_screen_id=lds_dw.getitemnumber(ll_i,'scr_id')
	if IsNull(ls_dataobject) or LenA(Trim(ls_dataobject)) < 1 then continue;	
	
	lds_data.dataobject=ls_dataobject
	lds_data.insertrow(0)
	//
	ll_ccount=long(lds_data.describe("datawindow.column.count"))
	lds_properties.retrieve(ai_prf_view_id, ll_screen_id,'S')
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
	if lds_properties.update() <> 1 then 
		messagebox("error:","The table data_view_report_fields update failed!")
		return -1
	end if
next

DESTROY lds_dw
DESTROY lds_data
DESTROY lds_properties

RETURN 1





end function

public function integer of_add_screen2view (integer ai_profile_view_id, integer ai_profile_report_ids[]);//Add screens to a profile view, called in profile painter.
//By Alfee 02.16.2009

int			li_prfid, li_scrid, li_tableid, li_profile_report_ids[], li_rtn=1
Long 			i, ll_found, ll_cnt, ll_row, ll_cnt_ids, ll_cnt_fields, ll_cnt_objects
long			ll_dataview_fieldid, ll_fieldid, ll_objectid, li_fieldid
long			ll_x, ll_y, ll_width, ll_height, ll_weight, ll_italic, ll_just, ll_underline
string		ls_objects, ls_obj, ls_objtype, ls_dataobject, ls_band
string		ls_case, ls_mask,	ls_just, ls_visible, ls_underline, ls_text
boolean		lb_exists = false
datastore	lds_data, lds_profile_reports, lds_profile_reports_ids 
datastore   lds_profile_report_fields, lds_screen_report_objects

IF UpperBound(ai_profile_report_ids) < 1 THEN RETURN 0

//Initialize Datastores & variables
lds_data = CREATE datastore
lds_profile_reports = CREATE datastore
lds_profile_reports_ids = CREATE datastore
lds_profile_report_fields = CREATE datastore
lds_screen_report_objects = CREATE datastore

lds_profile_reports.Dataobject = 'd_profile_reports'
lds_profile_reports_ids.Dataobject = 'd_profile_report_fields_byname'
lds_profile_report_fields.Dataobject = 'd_profile_report_fields_upd_byscr'
lds_screen_report_objects.Dataobject = 'd_screen_report_objects_upd_byscr'

lds_profile_reports.SetTransObject(SQLCA)
lds_profile_reports_ids.SetTransObject(SQLCA)
lds_profile_report_fields.SetTransObject(SQLCA)
lds_screen_report_objects.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
ll_cnt = lds_profile_reports.Retrieve()
ll_cnt_ids = lds_profile_reports_ids.Retrieve(ai_profile_view_id, ai_profile_report_ids)
ll_cnt_fields = lds_profile_report_fields.Retrieve(ai_profile_view_id, 'P', ai_profile_report_ids)
ll_cnt_objects = lds_screen_report_objects.Retrieve(ai_profile_view_id, 'P', ai_profile_report_ids)

select max(data_view_field_id) into :ll_dataview_fieldid from data_view_report_fields;
select max(data_view_object_id) into :ll_objectid from screen_report_objects;
gnv_appeondb.of_commitqueue( )

//-----Begin Added by Alfee 04.23.2009----------------
//<$Reason>Can't get the row count in an Appeon Queue
ll_cnt = lds_profile_reports.RowCount()
ll_cnt_ids = lds_profile_reports_ids.RowCount()
ll_cnt_fields = lds_profile_report_fields.RowCount()
ll_cnt_objects = lds_screen_report_objects.RowCount()
//------End Added ------------------------------------

IF IsNull(ll_dataview_fieldid) THEN ll_dataview_fieldid = 0
IF IsNull(ll_objectid) THEN ll_objectid = 0

//filter report ids which are already existed in DB
IF ll_cnt_fields > 0 OR ll_cnt_objects > 0 THEN
	FOR i = 1 to UpperBound(ai_profile_report_ids)
		IF (ll_cnt_fields < 1 OR lds_profile_report_fields.Find("screen_id = " + String(ai_profile_report_ids[i]), 1, ll_cnt_fields) < 1 ) AND &
			(ll_cnt_objects < 1 OR lds_screen_report_objects.Find("screen_id = " + String(ai_profile_report_ids[i]), 1, ll_cnt_objects) < 1) THEN
			li_profile_report_ids[UpperBound(li_profile_report_ids)+ 1] = ai_profile_report_ids[i]		
		END IF	
	NEXT
ELSE
	li_profile_report_ids = ai_profile_report_ids
END IF

//Generate properties data for specified report ids 
FOR i = 1 to UpperBound(li_profile_report_ids)
	//Get dataobject name
	ll_found = lds_profile_reports.Find('profile_report_id = ' + string(li_profile_report_ids[i]), 1, ll_cnt)
	IF IsNull(ll_found) OR ll_found < 1 THEN CONTINUE;
	ls_dataobject = lds_profile_reports.GetItemString(ll_found, 'profile_report_dw')
	IF IsNull(ls_dataobject) OR LenA(Trim(ls_dataobject)) < 1 THEN CONTINUE;

	//Filter fields ids datawindow 
	li_prfid = li_profile_report_ids[i]
	lds_profile_reports_ids.SetFilter('prf_id = ' + String(li_prfid))
	lds_profile_reports_ids.Filter()
	ll_cnt_ids = lds_profile_reports_ids.RowCount()
	
	//Get and copy properties from the physical datawindow
	lds_data.dataobject = ls_dataobject
	ls_objects=lds_data.describe("datawindow.objects")+'~t'
	ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
	
	do while LenA(ls_obj)>0	
		//Get properties
		ls_visible=lds_data.describe(ls_obj+".visible")
		//----Begin Modified by Alfee 01.25.2010----------
		//<$Reason>Add these invisible fields
		if ls_visible='0' then 
			ls_visible = 'N'
		else
			ls_visible = 'Y'
		end if
		/* if ls_visible='0' then
			ls_objects=mid(ls_objects,pos(ls_objects,'~t')+len('~t'))
			ls_obj=left(ls_objects,pos(ls_objects,'~t') - 1)
			continue
		end if
		if len(ls_visible)>1 then setnull(ls_visible)
		ls_visible='Y'	*/
		//----End Modified -----------------------------------
		ls_case=lower(lds_data.describe(ls_obj+".Edit.Case"))
		if ls_case='?' or ls_case='any' then
			ls_case='0'
		elseif ls_case='upper' then
			ls_case='1'
		elseif ls_case='lower' then	
			ls_case='2'
		end if		
		ls_mask=lds_data.describe(ls_obj+".format")
		ll_x=long(lds_data.describe(ls_obj+".x"))
		ll_y=long(lds_data.describe(ls_obj+".y"))
		ll_width=long(lds_data.describe(ls_obj+".width"))
		ll_height=long(lds_data.describe(ls_obj+".height"))
		ls_just=lds_data.describe(ls_obj+".Alignment")
		ll_just=long(ls_just)	
		ll_weight=long(lds_data.describe(ls_obj+".Font.Weight"))
		ls_underline=lds_data.describe(ls_obj+".Font.Underline")
		if ls_underline='?' then ls_underline='0'
		ll_underline=long(ls_underline)
		ll_italic=long(lds_data.describe(ls_obj+".Font.Italic"))
		ls_text=lds_data.describe(ls_obj+".text")
		ls_band=lds_data.describe(ls_obj+".band") //(v12.1 meeting) - alfee 02.22.2012
		
		//Copy properties
		ls_objtype=lds_data.describe(ls_obj+".type")
		//update properties in data_view_report_fields for column		
		if ls_objtype='column' then 
				ll_fieldid = -1
				//ll_found = lds_profile_reports_ids.Find("field_name = '" + ls_obj + "'", 1, ll_cnt_ids)
				ll_found = lds_profile_reports_ids.Find("Upper(field_name) = '" + Upper(ls_obj) + "'", 1, ll_cnt_ids) //BugA071903 - alfee 08.26.2011
				IF ll_cnt_ids > 0 AND ll_found > 0 THEN 
					ll_fieldid = lds_profile_reports_ids.GetItemNumber(ll_found, 'field_id')	
				END IF
				ll_dataview_fieldid ++	
				ll_row = lds_profile_report_fields.InsertRow(0)
				lds_profile_report_fields.SetItem(ll_row, 'data_view_field_id', ll_dataview_fieldid)
				lds_profile_report_fields.SetItem(ll_row, 'data_view_id', 1)
				lds_profile_report_fields.SetItem(ll_row, 'screen_id', li_prfid)
				lds_profile_report_fields.SetItem(ll_row, 'field_id', ll_fieldid)
				lds_profile_report_fields.SetItem(ll_row, 'field_x', ll_x)
				lds_profile_report_fields.SetItem(ll_row, 'field_y', ll_y)
				lds_profile_report_fields.SetItem(ll_row, 'field_width', ll_width)
				lds_profile_report_fields.SetItem(ll_row, 'field_height', ll_height)
				lds_profile_report_fields.SetItem(ll_row, 'justification', ls_just)
				lds_profile_report_fields.SetItem(ll_row, 'font_wieght', ll_weight)				
				lds_profile_report_fields.SetItem(ll_row, 'field_underline', ls_underline)				
				lds_profile_report_fields.SetItem(ll_row, 'field_font_italic', ll_italic)				
				lds_profile_report_fields.SetItem(ll_row, 'visible', ls_visible)								
				lds_profile_report_fields.SetItem(ll_row, 'ismodify', '0')					
				lds_profile_report_fields.SetItem(ll_row, 'report_from', 'P')									
				lds_profile_report_fields.SetItem(ll_row, 'profile_view_id', ai_profile_view_id)	
		//update properties in screen_report_objects for other object
		else 
				ll_objectid ++	
				ll_row = lds_screen_report_objects.InsertRow(0)
				lds_screen_report_objects.SetItem(ll_row, 'data_view_object_id', ll_objectid)
				lds_screen_report_objects.SetItem(ll_row, 'data_view_id', 1)
				lds_screen_report_objects.SetItem(ll_row, 'screen_id', li_prfid)
				lds_screen_report_objects.SetItem(ll_row, 'object_name', ls_obj)
				lds_screen_report_objects.SetItem(ll_row, 'object_text', ls_text)				
				lds_screen_report_objects.SetItem(ll_row, 'object_width', ll_width)
				lds_screen_report_objects.SetItem(ll_row, 'object_height', ll_height)				
				lds_screen_report_objects.SetItem(ll_row, 'object_x', ll_x)				
				lds_screen_report_objects.SetItem(ll_row, 'object_y', ll_y)				
				lds_screen_report_objects.SetItem(ll_row, 'object_alignment', ll_just)
				lds_screen_report_objects.SetItem(ll_row, 'object_italic', ll_italic)				
				lds_screen_report_objects.SetItem(ll_row, 'object_bold', ll_weight)				
				lds_screen_report_objects.SetItem(ll_row, 'object_underline', ll_underline)
				lds_screen_report_objects.SetItem(ll_row, 'visible', ls_visible)
				lds_screen_report_objects.SetItem(ll_row, 'ismodify', '0')					
				lds_screen_report_objects.SetItem(ll_row, 'report_from', 'P')		
				lds_screen_report_objects.SetItem(ll_row, 'profile_view_id', ai_profile_view_id)
				lds_screen_report_objects.SetItem(ll_row, 'object_band', left(ls_band,30))	//(v12.1 meeting) - alfee 02.22.2012		
		end if
		ls_objects=MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
		ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
	loop
NEXT

//Update data into DB
IF lds_profile_report_fields.Modifiedcount( ) > 0 THEN 
	IF lds_profile_report_fields.Update() <> 1 THEN 
		MessageBox("Update Fields","Update field properties failed due to ~r~n" + SQLCA.SQLErrText) 
		li_rtn = -1		
	END IF
END IF		
IF li_rtn > 0 AND lds_screen_report_objects.Modifiedcount( ) > 0 THEN 
	IF lds_screen_report_objects.Update() <> 1 THEN 
		MessageBox("Update Objects","Update object properties failed due to ~r~n" + SQLCA.SQLErrText) 
		li_rtn = -1		
	END IF
END IF		

Destroy lds_data
Destroy lds_profile_reports_ids
Destroy lds_profile_reports
Destroy lds_profile_report_fields
Destroy lds_screen_report_objects

RETURN li_rtn
end function

public function integer of_delete_screen_properties (integer ai_prf_view_id, integer ai_screen_id[], string as_report_from);//Delete screen properties from profile for specified profile view and screen id
//By Alfee 02.16.2009
Long i
String ls_screen_ids, ls_sql[]

IF UpperBound(ai_screen_id) < 1 THEN RETURN 1

FOR i = 1 to UpperBound(ai_screen_id)
	IF IsNull(ai_screen_id[i]) THEN CONTINUE
	IF i <> 1 THEN ls_screen_ids +=","
	ls_screen_ids += String(ai_screen_id[i])
NEXT

ls_sql[1] = "DELETE FROM data_view_report_fields WHERE profile_view_id = " + String(ai_prf_view_id) + " AND screen_id in (" + ls_screen_ids + ") AND report_from = '" + as_report_from + "'; " 
ls_sql[2] = "DELETE FROM data_view_report_objects WHERE profile_view_id = " + String(ai_prf_view_id) + " AND screen_id in (" + ls_screen_ids + ") AND report_from = '" + as_report_from + "'; " 
ls_sql[3] = "DELETE FROM screen_report_objects WHERE profile_view_id = " + String(ai_prf_view_id) + " AND screen_id in (" + ls_screen_ids + ") AND report_from = '" + as_report_from + "'; " 
IF as_report_from = 'P' THEN 
	ls_sql[4] = "DELETE FROM profile_view_reports WHERE profile_view_id = " + String(ai_prf_view_id) + " AND profile_report_id in (" + ls_screen_ids + "); " 
END IF
gnv_appeondb.of_startqueue( )
	FOR i = 1 TO UpperBound(ls_sql)
		Execute Immediate :ls_sql[i] Using SQLCA;
	NEXT
gnv_appeondb.of_commitqueue( )

IF SQLCA.SQLCode <> 0 THEN RETURN -1

RETURN 1


end function

public function integer of_copy_screen_properties (integer ai_prf_view_id, integer ai_data_view_id, integer ai_screen_ids[], integer ai_prf_ids[]);//Copy fields and objects' properties from data entry screen to profile report
//while a new data entry screen is selected via changing model(profile save in v8.1).
//By alfee 02.16.2009
//Add properties for the report header under screen mode - alfee 02.09.2010
//Added the argumemt of ai_prf_ids[] by alfee 12.30.2014

Integer li_rtn = 1
Long ll_cnt_fields, ll_cnt_objects, ll_cnt_hdrs, i
Long ll_max_field_id, ll_max_object_id, ll_max_hdr_id
Long ll_field_max_y, ll_obj_max_y, ll_max_field_order //alfee 12.27.2014

DataStore ds_screen_fields, ds_report_fields_upd
DataStore ds_screen_objects, ds_report_objects_upd
DataStore ds_report_hdr, ds_report_hdr_upd 

ds_screen_fields = Create DataStore
ds_report_fields_upd = Create DataStore
ds_screen_objects = Create DataStore
ds_report_objects_upd = Create DataStore
ds_report_hdr = Create DataStore
ds_report_hdr_upd = Create DataStore

ds_screen_fields.DataObject = 'd_data_view_fields_4prf'
ds_report_fields_upd.DataObject = 'd_data_view_report_fields_upd'
ds_screen_objects.DataObject = 'd_data_view_screen_objects_4prf'
ds_report_objects_upd.DataObject = 'd_data_view_report_objects_upd'
ds_report_hdr.dataobject = 'd_screen_report_objects_4hdr'
ds_report_hdr_upd.dataobject = 'd_screen_report_hdr_upd'

ds_screen_fields.SetTransObject(SQLCA)
ds_report_fields_upd.SetTransObject(SQLCA)
ds_screen_objects.SetTransObject(SQLCA)
ds_report_objects_upd.SetTransObject(SQLCA)
ds_report_hdr.SetTransObject(SQLCA)
ds_report_hdr_upd.SetTransObject(SQLCA)

 //for personal information - alfee 12.27.2014
FOR i = 1 TO UpperBound(ai_screen_ids)
	IF ai_screen_ids[i] = 1 THEN
		ai_screen_ids[UpperBound(ai_screen_ids)+1] = 27
		EXIT
	END IF		
NEXT

gnv_appeondb.of_startqueue( )
ds_screen_fields.Retrieve(ai_prf_view_id, ai_data_view_id, ai_screen_ids)
ds_screen_objects.Retrieve(ai_prf_view_id, ai_data_view_id, ai_screen_ids)
//ds_report_hdr.Retrieve(ai_prf_view_id, ai_data_view_id, ai_screen_ids, ai_prf_ids) //Same screen id for different profiles - alfee 12.30.2014
ds_report_hdr.Retrieve(ai_prf_view_id, ai_screen_ids, ai_prf_ids) //alfee 06.12.2015
//ds_report_hdr.Retrieve(ai_prf_view_id, ai_data_view_id, ai_screen_ids)
Select Max(data_view_field_id) into :ll_max_field_id from data_view_report_fields ;
Select Max(data_view_object_id) into :ll_max_object_id from data_view_report_objects ;
Select Max(data_view_object_id) into :ll_max_hdr_id from screen_report_objects ;
Select IsNull(max(field_y + field_height), 0), max(field_order) into :ll_field_max_y, :ll_max_field_order from data_view_fields where data_view_id = :ai_data_view_id and screen_id = 1; //alfee 12.27.2014
Select IsNull(max(object_y + object_height), 0) into :ll_obj_max_y from data_view_screen_objects where data_view_id = :ai_data_view_id and screen_id = 1; //alfee 12.27.2014
gnv_appeondb.of_commitqueue( )

//-----Begin Added by Alfee 04.23.2009----------------
//<$Reason>Can't get the row count in an Appeon Queue
ll_cnt_fields = ds_screen_fields.RowCount()
ll_cnt_objects = ds_screen_objects.RowCount()
//------End Added ------------------------------------
ll_cnt_hdrs = ds_report_hdr.RowCount()

IF IsNull(ll_max_field_id) THEN ll_max_field_id = 0
IF IsNull(ll_max_object_id) THEN ll_max_object_id = 0

IF ll_cnt_fields > 0 AND ds_screen_fields.RowsCopy(1, ll_cnt_fields, Primary!, ds_report_fields_upd, 1, Primary!) > 0 THEN
	FOR i = 1 to ds_report_fields_upd.RowCount()
		ll_max_field_id ++
		ds_report_fields_upd.SetItem(i, 'data_view_id', 1) //alfee 04.14.2009
		ds_report_fields_upd.SetItem(i, 'data_view_field_id', ll_max_field_id)
		ds_report_fields_upd.SetItem(i, 'label_underline', '0')
		ds_report_fields_upd.SetItem(i, 'label_font_weight', 700)
		//alfee 12.27.2014
		IF ds_report_fields_upd.GetItemNumber(i, 'screen_id') = 27 THEN
			ds_report_fields_upd.SetItem(i, 'screen_id', 1)
			ds_report_fields_upd.SetItem(i, 'visible', 'N')
			ds_report_fields_upd.SetItem(i, 'field_y', ds_report_fields_upd.GetItemNumber(i, 'field_y') + ll_field_max_y)
			ds_report_fields_upd.SetItem(i, 'field_label_y', ds_report_fields_upd.GetItemNumber(i, 'field_label_y') + ll_field_max_y)			
			ds_report_fields_upd.SetItem(i, 'field_order', ds_report_fields_upd.GetItemNumber(i, 'field_order') + ll_max_field_order)			
		END IF		
	NEXT
END IF

IF ll_cnt_objects > 0 AND ds_screen_objects.RowsCopy(1, ll_cnt_objects, Primary!, ds_report_objects_upd, 1, Primary!) > 0 THEN
	FOR i = 1 to ds_report_objects_upd.RowCount()
		ll_max_object_id ++
		ds_report_objects_upd.SetItem(i,'data_view_id', 1) //alfee 04.14.2009		
		ds_report_objects_upd.SetItem(i,'data_view_object_id', ll_max_object_id)		
		//alfee 12.27.2014
		IF ds_report_objects_upd.GetItemNumber(i, 'screen_id') = 27 THEN
			ds_report_objects_upd.SetItem(i, 'screen_id', 1)
			ds_report_objects_upd.SetItem(i, 'object_y', ds_report_objects_upd.GetItemNumber(i, 'object_y') + ll_field_max_y)
		END IF			
	NEXT
END IF

IF ll_cnt_hdrs > 0 AND ds_report_hdr.RowsCopy(1, ll_cnt_hdrs, Primary!, ds_report_hdr_upd, 1, Primary!) > 0 THEN
	FOR i = 1 to ds_report_hdr_upd.RowCount()
		ll_max_hdr_id ++
		ds_report_hdr_upd.SetItem(i,'data_view_id', 1) 
		ds_report_hdr_upd.SetItem(i,'data_view_object_id', ll_max_hdr_id)		
	NEXT
END IF

IF ll_cnt_fields > 0 OR ll_cnt_objects > 0 OR ll_cnt_hdrs > 0 THEN
	//Update copied fields and objects' properties
	IF gnv_appeondb.of_update( ds_report_fields_upd, ds_report_objects_upd, ds_report_hdr_upd) < 0 THEN li_rtn = -1
	//Set ismodify field in data_view_report_fields
	IF li_rtn > 0 THEN li_rtn = of_set_field_modified(ai_prf_view_id, ai_screen_ids)
END IF

Destroy ds_screen_fields
Destroy ds_report_fields_upd
Destroy ds_screen_objects
Destroy ds_report_objects_upd
Destroy ds_report_hdr
Destroy ds_report_hdr_upd

RETURN li_rtn

//FOR i = 1 TO UpperBound(ai_screen_id)
//	//Determine if fields' properties will be added
//	SELECT Count(*) INTO :ll_cnt FROM data_view_report_fields WHERE report_from = 'S' AND profile_view_id = :ai_prf_view_id AND data_view_id = 1 AND screen_id = :ai_screen_id[i]; 
//
//	//Copy fields' properties from data entry screen
//	ls_sql_statements[upperbound(ls_sql_statements) + 1] =& 
//	"insert data_view_report_fields(data_view_field_id,data_view_id,screen_id,field_id,field_label,field_order,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible,font_wieght,tab_address,back_address,label_underline,field_underline,field_font_italic,label_font_italic,label_font_weight,report_from,profile_view_id)    " + &
//	"select data_view_field_id,1 as data_view_id,screen_id,field_id,field_label,field_order,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible,font_wieght,tab_address,back_address,label_underline,field_underline,field_font_italic,label_font_italic,label_font_weight,'S'," + String(ai_prf_view_id) + "  " + &
//	"  from data_view_fields    " + &
//	" where data_view_id = " + String(ai_data_view_id) + " "  + &
//	"	 and screen_id = " + String(ai_screen_id[i]) + " " + &
//	"	 and NOT EXISTS(select * from data_view_report_fields " + &
//	"						  where profile_view_id = " + String(ai_prf_view_id) + " "  + &
// 	"							 and data_view_id = 1 and screen_id=data_view_fields.screen_id  "  + &
//	"							 and report_from = 'S' and data_view_field_id=data_view_fields.data_view_field_id )"
//
//	//Set field labels bold and underline properties for new added fields
//	IF ll_cnt < 1 THEN 
//		ls_sql_statements[upperbound(ls_sql_statements) + 1] =& 
//		"update data_view_report_fields set label_underline = '0' where report_from = 'S' and profile_view_id = " + String(ai_prf_view_id) + " and data_view_id = 1 and screen_id = " + String(ai_screen_id[i]) + " and label_underline = '1' "
//		ls_sql_statements[upperbound(ls_sql_statements) + 1] =& 
//		"update data_view_report_fields set label_font_weight = 700 where report_from = 'S' and profile_view_id = " + String(ai_prf_view_id) + " and data_view_id = 1 and screen_id = " + String(ai_screen_id[i]) + " "
//	END IF	
//
//
//	//Copy objects' properties from data entry screen
//	ls_sql_statements[upperbound(ls_sql_statements) + 1] =& 
//	"insert data_view_report_objects(data_view_object_id,data_view_id,screen_id,object_text,object_width,object_height,object_x,object_y,object_alignment,object_italic,object_bold,object_underline,object_color,object_type,object_justification,report_from,profile_view_id)    " + &
//	"select data_view_object_id,1 as data_view_id,screen_id,object_text,object_width,object_height,object_x,object_y,object_alignment,object_italic,object_bold,object_underline,object_color,object_type,object_justification,'S'," + String(ai_prf_view_id) + "  " + &
//	"  from data_view_screen_objects    " + &
//	" WHERE data_view_id = " + String(ai_data_view_id) + " "  + &
//	"	 and screen_id = " + String(ai_screen_id[i]) + " " + &
//	"	 and NOT EXISTS(select * from data_view_report_objects    " + &
//	"                   where profile_view_id = " + String(ai_prf_view_id) + " "  + &
// 	"							 and data_view_id = 1 and screen_id=data_view_screen_objects.screen_id  "  + &
//	" 							 and report_from = 'S' and data_view_object_id=data_view_screen_objects.data_view_object_id ) " 
//
//NEXT
//
////Execute the above sql statements
//gnv_appeondb.of_startqueue( )
//FOR i = 1 TO upperbound(ls_sql_statements)
//	EXECUTE Immediate :ls_sql_statements[i] Using Sqlca;
//	IF appeongetclienttype() = 'PB' AND Sqlca.SQLCode <> 0 THEN RETURN -1
//NEXT
//gnv_appeondb.of_commitqueue( )
//
////Set ismodify field in data_view_report_fields
//IF upperbound(ls_sql_statements) > 0 THEN
//	IF Sqlca.SQLCode <> 0 THEN RETURN -1
//	of_set_field_modified(ai_prf_view_id, ai_screen_id)
//END IF

end function

on pfc_cst_nv_profile_report_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_nv_profile_report_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

