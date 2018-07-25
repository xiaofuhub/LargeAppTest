$PBExportHeader$w_app_data_compare.srw
forward
global type w_app_data_compare from window
end type
type dw_link_list from u_dw within w_app_data_compare
end type
type dw_select_section from u_dw within w_app_data_compare
end type
type dw_browse from u_dw within w_app_data_compare
end type
type cb_2 from commandbutton within w_app_data_compare
end type
type cb_close from commandbutton within w_app_data_compare
end type
type ole_edit from olecustomcontrol within w_app_data_compare
end type
type ole_admin from olecustomcontrol within w_app_data_compare
end type
type dw_detail from u_dw within w_app_data_compare
end type
end forward

global type w_app_data_compare from window
integer width = 4635
integer height = 2904
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
dw_link_list dw_link_list
dw_select_section dw_select_section
dw_browse dw_browse
cb_2 cb_2
cb_close cb_close
ole_edit ole_edit
ole_admin ole_admin
dw_detail dw_detail
end type
global w_app_data_compare w_app_data_compare

type variables
long il_prac_id
integer ii_screen_id
integer il_data_view
long ii_parent
string is_lookup_search_column_table
string is_sql_syntax
long il_rec_id
pfc_cst_nv_data_entry_functions   inv_data_entry
end variables

forward prototypes
public function integer of_setup ()
end prototypes

public function integer of_setup ();dw_detail.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_image.dw_detail_2.of_SetDropDownCalendar( TRUE )
//dw_ver_data.of_SetDropDownCalendar( TRUE )
//ib_just_open = true
dw_select_section.Reset()
dw_select_section.of_SetTransObject(SQLCA)

//if ib_report=false then
	dw_select_section.Retrieve( il_data_view )
	
	dw_select_section.SelectRow( 1, True )
	
//	IF ab_new_prac THEN
//		st_recs.Text = "Record 1 of 1"
//	ELSE
		if dw_detail.rowcount() > 0 then
			il_rec_id = dw_detail.GetItemNumber( 1, "rec_id" )
		end if
//	END IF
//else
//	dw_select_section.Retrieve( il_data_view,999 ) //default 999
//	dw_select_section.SelectRow( 1, True )
//end if


Return 1
end function

on w_app_data_compare.create
this.dw_link_list=create dw_link_list
this.dw_select_section=create dw_select_section
this.dw_browse=create dw_browse
this.cb_2=create cb_2
this.cb_close=create cb_close
this.ole_edit=create ole_edit
this.ole_admin=create ole_admin
this.dw_detail=create dw_detail
this.Control[]={this.dw_link_list,&
this.dw_select_section,&
this.dw_browse,&
this.cb_2,&
this.cb_close,&
this.ole_edit,&
this.ole_admin,&
this.dw_detail}
end on

on w_app_data_compare.destroy
destroy(this.dw_link_list)
destroy(this.dw_select_section)
destroy(this.dw_browse)
destroy(this.cb_2)
destroy(this.cb_close)
destroy(this.ole_edit)
destroy(this.ole_admin)
destroy(this.dw_detail)
end on

event open;//retrieve data entry
long ll_dv
long ll_prac
long ll_parent
gs_variable_array lst_ids

lst_ids = message.powerobjectparm

ll_dv = lst_ids.as_number[1]
ll_prac = lst_ids.as_number[2]
ll_parent = lst_ids.as_number[3]

il_data_view = ll_dv
il_prac_id = ll_prac
ii_parent  = ll_parent
of_setup( )

//window lw
//lw = this
// uo_data.of_set_parent_window( lw )
 inv_data_entry = create pfc_cst_nv_data_entry_functions  

Return 0
end event

event close;destroy inv_data_entry
end event

type dw_link_list from u_dw within w_app_data_compare
integer x = 1541
integer y = 24
integer width = 183
integer height = 104
integer taborder = 50
boolean bringtotop = true
end type

event buttonclicked;call super::buttonclicked;//String ls_field
//Integer li_rc
//Integer i
//String ls_type
//string s //maha 03.22.2011
//
//if dwo.Name =  "b_filter" then
//	of_filter_links("Click")
//	return 1
//end if
//
//if dwo.Name =  "b_addr_help" then
//	s = "Primary Address is used in report and Application mapping filtering.~r~r"
//	s+= "Additional Address is used in report and application mapping filtering.~r~r"
//	s+= "Billing Address is used in report and mapping filtering, and also determines which addresses appear in the Billing Address link dropdown.~r~r"
//	s+= "Home Address is used in report and Application mapping filtering.~r~r"
//	s+= "Mailing Address is used when sending Correspondence or Expiring Appointment Letters.~r~r"
//	s+= "The Expiring Credential Address is used when mailing Expiring credential letters.~r~r"
//	s+= "Directory is used to define which Addresses are included in Standard Directory reports.~r~r"
//	s+= "The arrow buttons will copy the value in the first row to the other rows (when all rows are showing)"
//	messagebox("About Links",s)
//	return 1
//end if
//
//
//CHOOSE CASE dwo.Name
//	CASE "p"
//		ls_field = "primary_office"
//		ls_type = "1"
//	CASE "a"		
//		ls_field = "additional_office"		
//		ls_type = "1"		
//	CASE "b"
//		ls_field = "billing"				
//		ls_type = "1"		
//	CASE "h"
//		ls_field = "home_address"				
//		ls_type = "1"		
//	CASE "m"
//		ls_field = "mailing"				
//		ls_type = "1"		
//	CASE "e"
//		ls_field = "exp_letters"		
//		ls_type = "1"		
//	CASE "d"
//		ls_field = "include_in_directory"				
//		ls_type = "1"		
//	CASE "hospital"
//		ls_field = "pd_hosp_facility_link_primary_hosp"
//		ls_type = "2"		
//	CASE "specialty"
//		ls_field = "pd_spec_facility_link_practicing"
//		ls_type = "2"	
//END CHOOSE
//
//
//li_rc = This.RowCount()
//FOR i = 1 TO li_rc
//	IF ls_type = "1" THEN	
//		IF This.GetItemNumber( 1, ls_field ) = 1 THEN
//			This.SetItem( i, ls_field, 1 )
//		ELSE
//			This.SetItem( i, ls_field, 0 )			
//		END IF
//	ELSE
//		IF This.GetItemNumber( 1, ls_field ) = 581 THEN
//			This.SetItem( i, ls_field, 581 )
//		ELSE
//			This.SetItem( i, ls_field, 582 )			
//		END IF
//	END IF
//END FOR
//
////Start Code Change ----08.05.2009 #V92 maha - reset focus so add works
//dw_detail.setfocus()
////End Code Change---08.05.2009
//
end event

event constructor;call super::constructor;This.of_SetTransObject( sqlca )
end event

event itemchanged;call super::itemchanged;long ll_specialty_id,ll_practicing
dw_detail.SetFocus()

IF This.GetColumnName() = "primary_office" AND data = "1" THEN
	This.SetItem( row, "additional_office", 0 )
ELSEIF This.GetColumnName() = "additional_office" AND data = "1" THEN
	This.SetItem( row, "primary_office", 0 )
END IF

end event

event retrieveend;call super::retrieveend;//of_filter_links("One") //Start Code Change ----10.21.2010 #V10 maha - filter to one facility record
end event

event pfc_addrow;Return 1
end event

event pfc_preupdate;call super::pfc_preupdate;////jad 8/21/01
//Integer li_rc
//Integer i
//
//li_rc = This.RowCount()
//
////if is_screen_name = "Address"  then //maha 082301
//if ii_screen_id = 2 then
//
//	FOR i = 1 TO li_rc
//		IF This.GetItemStatus( i, 0, Primary!)  = DataModified! THEN
//			IF of_address_link_check() = -1 THEN
//				//debugbreak()
//				Return Failure
//			END IF
//		END IF
//	END FOR
//end if

Return Success
end event

type dw_select_section from u_dw within w_app_data_compare
event pfc_after_select ( )
event ue_goto_status ( )
event pfc_cst_after_error ( )
integer x = 59
integer y = 80
integer width = 1125
integer height = 164
integer taborder = 40
boolean bringtotop = true
string title = "Select Data Screen"
string dataobject = "d_data_view_screens_list"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event pfc_after_select();String	ls_PicPath,ls_PicName,ls_Postfix

//IF dw_browse.RowCount() > 1 THEN
//	dw_browse.SelectRow( 1, True )
//	dw_browse.ScrollToRow( 1 )
//	dw_browse.SetRow( 1 )
//	tab_view.tabpage_details.Enabled = True
//	tab_view.tabpage_browse.Enabled = True
//	dw_browse.SetFocus()	
//ELSE
//	dw_browse.Visible = False
//	dw_detail.Visible = True
//	dw_detail.SetFocus( )
//	dw_detail.ScrollToRow( 1 )
//	dw_detail.SetRow( 1 )
//	dw_detail.PostEvent("pfc_after_select")	
//END IF

// maha 080200
//if is_screen_name = "Address" then
//if ii_screen_id = 2 then
//	il_addr_id = dw_browse.getitemnumber(1,"rec_id")
//	dw_link_list.dataobject = "d_addr_link_check_boxes"//
//	dw_link_list.settransobject(sqlca)	//
//	dw_link_list.retrieve(il_addr_id)
//end if
////\ maha
//
////\/ maha 011501
////if is_screen_name = "Hospital Affiliation" then
//if ii_screen_id = 10 then
//	il_hosp_id = dw_browse.getitemnumber(1,"rec_id")
//	dw_link_list.dataobject = "d_hosp_facil_link_de"//
//	dw_link_list.settransobject(sqlca)//
//	dw_link_list.retrieve(il_hosp_id)//
//end if
////\ maha
//
////\/ maha 082001
////if is_screen_name = "Board/Specialty" then
//if ii_screen_id = 19 then
//	il_hosp_id = dw_browse.getitemnumber(1,"rec_id")
//	dw_link_list.dataobject = "d_spec_facil_link_de"//
//	dw_link_list.settransobject(sqlca)//
//	dw_link_list.retrieve(il_hosp_id)//
//end if
//\ maha
//\/maha 072301 prac picture
//if is_screen_name = "Basic Information" then
if ii_screen_id = 1 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2008-07-10 By: Scofield
	//$<Reason> Display Picture if the file is exist.
	
	//	string path
	//	
	//	path = gnv_data.of_getitem("ids" , "picture_path" , False)
	//
	//	path =  path + "\" + string(gl_prac_id) + ".bmp"
	//
	//	if FileExists(path) then 
	//		parent_window.tab_1.tabpage_detail.p_face.visible = true
	//		parent_window.tab_1.tabpage_detail.p_face.bringtotop = true
	//		parent_window.tab_1.tabpage_detail.p_face.picturename = path
	//	else 
	//		parent_window.tab_1.tabpage_detail.p_face.visible = false
	//	end if

	//------------------- APPEON BEGIN -------------------
	//$<modify> Evan 06.17.2009
	//$<reason> Menu readonly security.
	//if IsValid(m_pfe_cst_data_entry) then m_pfe_cst_data_entry.m_file.m_importphoto.Enabled = true
	if IsValid(m_pfe_cst_data_entry) then
		if w_mdi.of_security_access( 40 ) < 2 or w_mdi.of_security_access( 50 ) < 2 then
			m_pfe_cst_data_entry.m_file.m_importphoto.enabled = false
			m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = false  //maha072209
		else
			m_pfe_cst_data_entry.m_file.m_importphoto.enabled = true
			m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = true //maha072209
		end if
	end if
	//------------------- APPEON END ---------------------
	
	SELECT image_type INTO :ls_Postfix from pd_photo WHERE pd_photo.prac_id = :gl_prac_id ;
	
	if IsNull(ls_Postfix) or Trim(ls_Postfix) = "" then
//		Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
		//Parent_Window.tab_1.tabpage_detail.p_face.PictureName = "nophoto.bmp"
	else
		ls_PicPath = TRIM(gnv_data.of_getitem("ids","picture_path",false))
		if Right(ls_PicPath,1) <> "\" then ls_PicPath += "\"
		
//		ls_PicName = ls_PicPath + String(gl_prac_id) + "." + ls_Postfix
		
//		of_Download_Photo(gl_prac_id,ls_PicPath)
		
//		if FileExists(ls_PicName) then
//			Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
//			//Parent_Window.tab_1.tabpage_detail.p_face.Visible = true
//			Parent_Window.tab_1.tabpage_detail.p_face.BringToTop = true
//			Parent_Window.tab_1.tabpage_detail.p_face.PictureName = ""
//			Parent_Window.tab_1.tabpage_detail.p_face.PictureName = ls_PicPath + String(gl_prac_id) + "." + ls_Postfix
//		else
//			Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
//		end if
	end if
//---------------------------- APPEON END ----------------------------
	
	
//Start Code Change ----04.23.2008 #V8 maha	- modification to set ssn /npi from search
	if mid(gs_ssnnpi,1,1 ) = "S" then
		if dw_detail.Describe("ssn.ColType") <> "!" then
			if isnull(dw_detail.getitemstring(1,"ssn")) then dw_detail.setitem(1,"ssn", mid(gs_ssnnpi,3)) //Start Code Change ----11.17.2009 #V92 maha - changed to not overwrite
		end if
		gs_ssnnpi = ""
	elseif mid(gs_ssnnpi,1,1 ) = "N" then
		if dw_detail.Describe("npi_number.ColType") <> "!" then
			if isnull(dw_detail.getitemstring(1,"npi_number")) then dw_detail.setitem(1,"npi_number", mid(gs_ssnnpi,3))  //Start Code Change ----11.17.2009 #V92 maha - changed to not overwrite
		end if
		gs_ssnnpi = ""
	end if
//End Code Change---04.23.2008
else
	if IsValid(m_pfe_cst_data_entry) then 
		m_pfe_cst_data_entry.m_file.m_importphoto.Enabled = false		//Added by Scofield on 2008-09-23
		m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = false	//maha 072209
	end if
//	parent_window.tab_1.tabpage_detail.p_face.visible = false
end if
//End Code Change---04.23.2008

//Start Code Change ---- 06.15.2006 #545 maha removed existing code
//of_detail_scrollbar(ii_screen_id)
//End Code Change---06.15.2006

//of_links_security(ii_screen_id)   //Start Code Change ----05.26.2009 #V92 maha 

//if this is a custom screen then put a scroll bar on it
IF ii_screen_id > 100 THEN
	dw_detail.vscrollbar = True
END IF

SetRedraw(True)


end event

event ue_goto_status();//				Parent_window.tab_1.SelectTab( 3 )
//				Parent_window.tab_1.tabpage_apptmnt_status.uo_affill_status.of_new_record( il_prac_id )
//				Parent_window.tab_1.tabpage_apptmnt_status.uo_affill_status.of_set_new_prac( True )

end event

event pfc_cst_after_error;dw_detail.SetFocus()
end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.03.2006 By: LeiWei
//$<reason> Fix a defect.

IF row > 0 THEN
	This.Setrow( row )
END IF

//---------------------------- APPEON END ----------------------------

Integer li_row

li_row = This.GetClickedRow()

IF li_row = 0 THEN
	dw_detail.SetFocus()
END IF
end event

event constructor;This.of_Setupdateable(False)

end event

event retrieveend;call super::retrieveend;//used to change the icon for screens where the practitioner has data. 
//if  not ib_screen_painter then
//	of_screen_color()
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;
IF currentrow = 0 THEN
	Return
END IF

//if ib_report = true then return

Long ll_height
Long ll_data_view_id
Long ll_detail_2_screen_id
String ls_screen_name
Integer li_retval
Integer li_last_fld_y

//ii_address_lnk_cnt=0

//IF ib_refresh_screen_list = True THEN
//	This.SelectRow( 0, False )
//	This.SelectRow( il_last_row, True )
//	This.SetRow( il_last_row )
//	Return -1
//END IF
//	
//IF ib_screen_painter THEN
//	IF Parent_window_design.Event pfc_Save() < 0 THEN
//		This.SelectRow( 0, False )
//		This.SelectRow( il_last_row, True )
//		This.SetRow( il_last_row )
//		Return -1
//	END IF
//ELSE//	li_retval = Parent_window.Event pfc_Save()
//	IF li_retval < 0 THEN
//		This.SelectRow( 0, False )
//		This.SelectRow( il_last_row, True )
//		This.SetRow( il_last_row )
//		Return -1
//	END IF	
//END IF
//
//IF ib_refresh_screen_list = True THEN
//	Return
//END IF

ls_screen_name = This.GetItemString( currentrow, "screen_name" )
//messagebox('',ls_screen_name)


//SetRedraw(False)
//Start Code Change ---08.19.2008 #V85 maha - moved the detail 2 screen creation before the detail screen so that setting defaults will work
ll_data_view_id = This.GetItemNumber( currentrow, "data_view_id" )
ii_screen_id = This.GetItemNumber( currentrow, "screen_id" )
//IF This.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
//	ll_detail_2_screen_id = This.GetItemNumber( currentrow, "table_id_2" ) 
//	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ll_detail_2_screen_id,dw_link_list,dw_link_list, false, ii_parent )	
//	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
//	tab_view.tabpage_image.Visible = True
//else
//	tab_view.tabpage_image.Visible = False
//END IF

inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ii_screen_id, dw_detail, dw_browse,false, ii_parent , true)
//is_first_column_detail_1 = inv_data_entry.of_get_first_column()

//------------Begin Added by alfee 09.10.2010 -------------------------------------
//Add a button to access image(s) to the screen - SK Practitioner Folder
//if gb_sk_ver and not of_get_ib_screen_painter () then 
//if not of_get_ib_screen_painter () then 	//alfee 11.22.2010
//	long ll_cnt
//	select count(*) into :ll_cnt from pd_images, image_type 
//	 where pd_images.image_type_id = image_type.image_type_id 
//	   and pd_images.prac_id = :il_prac_id and image_type.link_to_screen = :ii_screen_id ;
//	if ll_cnt > 0 then 
//		if of_get_app_setting("set_img","I") = 1 and w_mdi.of_security_access(1000) > 0 then //Start Code Change ----05.11.2011 #V11 maha - security trap
//			dw_detail.Modify ("DataWindow.Header.Height= '110'" )
//			dw_detail.Modify("create button(band=header text='Access Image(s)' filename=''action='0' border='1' color='128' x='96' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = imgbutton)")
//		end if
//	end if		
//end if	
//------------End Added ---------------------------------------------------------------
//Start Code Change ----12.02.2010 #V10 maha - work gap calculation
if ii_screen_id = 12 then
	dw_detail.Modify ("DataWindow.Header.Height= '110'" )
	dw_detail.Modify("create button(band=header text='Calculate Work Gap' filename=''action='0' border='1' color='128' x='96' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = gapbutton)")
end if		
//End Code Change ----12.02.2010

//ll_data_view_id = This.GetItemNumber( currentrow, "data_view_id" )
//ii_screen_id = This.GetItemNumber( currentrow, "screen_id" )
//is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ii_screen_id, dw_detail, dw_browse, ib_screen_painter, ii_parent_facility_id )
//is_first_column_detail_1 = inv_data_entry.of_get_first_column()
//tab_view.tabpage_image.Visible = False
//IF This.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
//	ll_detail_2_screen_id = This.GetItemNumber( currentrow, "table_id_2" ) 
//	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ll_detail_2_screen_id, tab_view.tabpage_image.dw_detail_2, tab_view.tabpage_image.dw_detail_2, ib_screen_painter, ii_parent_facility_id )	
//	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
//	tab_view.tabpage_image.Visible = True
//END IF
//End Code Change---08.19.2008

This.SelectRow(0, False)
This.SelectRow( currentrow, True)

//IF This.GetItemString( currentrow, "multi_record" ) = "Y" THEN
//	tab_view.tabpage_browse.Enabled = True
//ELSE
//	tab_view.tabpage_browse.Enabled = False
//END IF

//ll_height = Long( dw_detail.Describe("DataWindow.Detail.Height") )


//Start Code Change ---- 06.15.2006 #546 maha
//of_detail_scrollbar(ii_screen_id)
//End Code Change---06.15.2006



//IF This.GetItemString( currentrow, "multi_record" ) = "Y" AND NOT ib_screen_painter AND dw_browse.RowCount() > 1 THEN
//	tab_view.SelectTab( 1 )	
//	dw_detail.Visible = False		
//	dw_browse.Visible = True	
//	dw_browse.SetFocus()	
//ELSE
//	tab_view.SelectTab( 2 )
//	dw_detail.SetFocus()
//	dw_detail.BringToTop = True	
//
	dw_detail.PostEvent("pfc_after_select")	
//END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-18
//$<comment> 02.08.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<reason> Comment out the following script, since li_last_fld_y is not used.
/*
SELECT Max( field_y )  
INTO :li_last_fld_y  
FROM data_view_fields  
WHERE data_view_fields.screen_id = :ii_screen_id AND
		data_view_fields.visible = 'Y';
*/
//---------------------------- APPEON END ----------------------------

//li_last_fld_y = li_last_fld_y + 110 //removed maha 051305 set in create dynamic dw (end)
//
//IF li_last_fld_y * 2 < dw_detail.Height THEN
//	dw_detail.Object.DataWindow.Detail.Height= String( li_last_fld_y )
//	dw_detail.vscrollbar = True
//END IF


dw_link_list.visible = false

//of_add_delete_enable()

dw_browse.SelectRow( 0, False)

//Start Code Change ----10.07.2009 #V10 maha - for Lehigh
//if of_get_app_setting("set_58","I") = 1 then
//	parent_window.title = parent_window.is_full_name  + " - " + String( parent_window.il_prac_id ) + "  (" + parent_window.is_facility_name + ")" + " - " + ls_screen_name 
//end if
//End Code Change---10.07.2009

This.PostEvent("pfc_after_select")

//il_last_row = currentrow
end event

event rowfocuschanging;call super::rowfocuschanging;Integer li_retval
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-19
//$<add> 03.03.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//$<modification> Write script to make sure that when pfc_cst_u_data_entry
//$<modification> is just opened, RowFocusChanging is not executed immediately.
//If ib_just_open Then
//	ib_just_open = False
//	return
//End If
If currentrow < 1 Then return
//---------------------------- APPEON END ----------------------------

//IF ib_screen_painter THEN
//	IF is_designer_type = "S" THEN
//		IF ib_report = False then
//			//BEGIN-Modify by Evan 12.14.2010
//			//IF Parent_window_design.Event pfc_Save() < 0 THEN
//			IF w_prac_data_design.Event pfc_Save() < 0 THEN
//			//END-Modify by Evan 12.14.2010
//				This.PostEvent( "pfc_cst_after_error" )
//				Return 1
//			END IF
//		ELSE
//			//BEGIN-Modify by Evan 12.14.2010
//			//IF Parent_window_design_report.Event pfc_Save() < 0 THEN
//			IF w_prac_report_design.Event pfc_Save() < 0 THEN
//			//END-Modify by Evan 12.14.2010
//				This.PostEvent( "pfc_cst_after_error" )
//				Return 1
//			END IF
//		END IF
//	ELSE
//		IF Parent_window_profile_design.Event pfc_Save() < 0 THEN
//			This.PostEvent( "pfc_cst_after_error" )
//			Return 1
//		END IF		
//	END IF
//ELSE
//	li_retval = Parent_window.Event pfc_Save()
//
//	IF li_retval < 0 THEN
//		This.PostEvent( "pfc_cst_after_error" )
//		Return 1
//	END IF	
//END IF

end event

event pfc_deleterow;Return 1
end event

event pfc_addrow;Return 1
end event

event pfc_firstpage;RETURN 0
end event

event pfc_lastpage;RETURN 0
end event

event pfc_nextpage;RETURN 0
end event

event pfc_previouspage;RETURN 0
end event

type dw_browse from u_dw within w_app_data_compare
event pfc_after_select ( )
integer x = 27
integer y = 308
integer width = 1257
integer height = 540
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
end type

event constructor;This.of_SetUpdateable(False)



end event

event doubleclicked;//IF dw_detail.RowCount() > 0 THEN
//	dw_detail.Visible = True
//	dw_browse.Visible = False
//	tab_view.SelectTab( 2 )
//	dw_detail.PostEvent( "pfc_after_select" )
//END IF



end event

event rowfocuschanged;call super::rowfocuschanged;This.SelectRow( 0, False )
This.SelectRow( This.GetRow(), True )

//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())

IF dw_detail.GetRow() <> currentrow THEN
	dw_detail.ScrollToRow( currentrow )
	dw_detail.SetRow( currentrow )
END IF

//IF currentrow > 0 THEN
//	of_get_record_verif( currentrow )
//END IF
//
//IF currentrow > 0 THEN //maha 092701
//	il_addr_id = dw_browse.getitemnumber(currentrow,"rec_id")
//end if
////\/maha 080200
////if is_screen_name = "Address" then
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-29
////$<modify> 2006-04-10 By: owen chen
////$<reason> Performance tuning modification
////$<modification> Add one more condition to reduces client-server interactions. 
///*
//if ii_screen_id = 2 then
//	dw_link_list.retrieve(il_addr_id)
//end if
//*/
//if (ii_screen_id = 2) and (ib_addaddress = false) then
//	dw_link_list.retrieve(il_addr_id)
//end if
////---------------------------- APPEON END ----------------------------
//
//
////\maha
////\/maha 011601
////if is_screen_name = "Hospital Affiliation" then
//if ii_screen_id = 10 then
//	dw_link_list.retrieve(il_addr_id)
//end if
////\maha
////\/maha 082001
////if is_screen_name = "Board/Specialty" then
//if ii_screen_id = 19 then
//	dw_link_list.retrieve(il_addr_id)
//end if
////\maha
end event

event pfc_deleterow;//Return of_delete_record( This )

return 0
end event

event pfc_addrow;//dw_detail.ScrolltoRow(dw_detail.RowCount())
//dw_detail.SetRow(dw_detail.RowCount())
//dw_browse.Visible = False
//dw_detail.Visible = True
//tab_view.SelectTab( 2 )
//dw_detail.Event pfc_addrow()
//dw_detail.BringToTop = True
//
////IF is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" or is_screen_name = "Board/Specialty" then //\/maha 082101 
//IF ii_screen_id = 10 or ii_screen_id = 2 or ii_screen_id = 19 THEN
////if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" then
//	dw_link_list.bringtotop = True
//end if

Return 0
end event

event pfc_nextpage;return this.ScrollNextRow() //Added By Ken.Guo 06.06.2008
end event

event pfc_previouspage;return this.ScrollPriorRow() //Added By Ken.Guo 06.06.2008
end event

type cb_2 from commandbutton within w_app_data_compare
integer x = 3529
integer y = 44
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

type cb_close from commandbutton within w_app_data_compare
integer x = 4197
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type ole_edit from olecustomcontrol within w_app_data_compare
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
integer x = 1353
integer y = 152
integer width = 3200
integer height = 2628
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_app_data_compare.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_admin from olecustomcontrol within w_app_data_compare
event filepropertiesclose ( )
boolean visible = false
integer x = 4242
integer y = 200
integer width = 155
integer height = 136
integer taborder = 30
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_app_data_compare.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type dw_detail from u_dw within w_app_data_compare
event ue_showlist pbm_custom01
event pfc_cst_preupdate pbm_custom02
event pfc_after_select ( )
event type integer ue_after_itemchanged ( string as_type )
integer y = 880
integer width = 1257
integer height = 1552
integer taborder = 40
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_after_select();//This.SetFocus()
//This.SetColumn( is_first_column_detail_1 )





end event

event type integer ue_after_itemchanged(string as_type);////maha 8-2005
//
//string s
//
//s = String(Message.LongParm, "address")
////messagebox("s",s)
//of_lookup_search_dddw(s)

return 1
end event

event buttonclicked;//DataWindowChild dwchild
//string s
//string ls_phone
//
//
//
//IF dwo.Name = "linkbutton" THEN
//	IF This.GetItemStatus( row, 0, Primary! ) = New! or This.GetItemStatus( row, 0, Primary! ) = NewModified! THEN
//		MessageBox("Save", "You need to first save the address record before applying address links." )
//		Return
//	ELSE
//		OpenWithParm( w_address_link, String( il_prac_id ) + "-" + String( dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id")) )	
//		//\/maha 080300
//		dw_link_list.retrieve( dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id")) 
//		//\maha
//	END IF
//ELSEIF dwo.Name = "findbutton" THEN
//	integer set1
////	select set_1
////	into :set1
////	from icred_settings;
//	set1 = of_get_app_setting("set_1","I")
//	
//	long ll_addr[ ]
//	Integer li_cr
//	Integer a
//	Integer li_address_cnt
//	gs_pass_ids ids
//	
//	if set1 <> 1 then 
//		
//		IF dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary! ) = DataModifIed! THEN
//			IF parent_window.Event pfc_Save() <> 1 THEN
//				Return
//			END IF
//	   END IF		
//		
//		
//		Open(w_practice_to_addr_find_new) 
//			
//		ids = Message.PowerObjectParm
//			
//		IF ids.l_ids[1] = 0 THEN
//			Return
//		END IF
//			
//		ll_addr[] = ids.l_ids[]
//			
//		li_address_cnt = UpperBound( ids.l_ids[] )
//			
//			
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<ID> PT-21
//		//$<modify> 2006-04-10 By: owen chen
//		//$<reason> Performance tuning modification
//		//$<modification> Use datawindow to retrieve data from the database instead 
//		//$<modification> of using SQLs in PT-22.
// 		/*
//		dw_addresses.dataobject = "d_group_data_entry"
//		dw_addresses.SetTransObject( SQLCA )
//		*/
//		dw_addresses.dataobject = "d_group_data_entry_for_pt"
//		dw_addresses.SetTransObject( SQLCA )
//		
//		if upperbound(ll_addr)>0 then
//			dw_addresses.Retrieve( ll_addr )
//		end if
//		
//		ib_addaddress = true
//		//---------------------------- APPEON END ----------------------------
//			
//		FOR a = 1 TO li_address_cnt
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<ID> PT-22
//			//$<modify> 2006-04-10 By: owen chen
//			//$<reason> Performance tuning modification
//			//$<modification> Write script to retrieve data from a cache in PT-21 instead of from the database. 
//			/*
//			dw_addresses.retrieve(  ll_addr[a] )
//			*/
//			dw_addresses.setfilter('rec_id = '+ string ( ll_addr[a] ))
//			dw_addresses.filter( )
//			//---------------------------- APPEON END ----------------------------
//			if gi_temp_switch = 0 then //maha 083004 for adds
//				IF a = 1 AND dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary! ) = NewModifIed! OR dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary! ) = New! THEN
//					dw_detail.DeleteRow( dw_detail.GetRow( ) )
//				END IF
//				this.triggerevent("pfc_addrow") //maha 090104 replaced insertrow()
//				li_cr = dw_detail.rowcount()
//				//li_cr = dw_detail.InsertRow( 0 )
//				//debugbreak()
//				//inv_data_entry.of_set_defaults( dw_detail, dw_detail.RowCount() )
//			else //maha 083004 to allow updating a record again
//				li_cr = dw_detail.getRow()
//			end if
//
//			if This.Describe("gp_id.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"gp_id", ll_addr[a] )
//			end if
//			if This.Describe("street.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"street",dw_addresses.getitemstring( 1,"street"))
//			end if
//
//			if This.Describe("street_2.ColType") <> "!" then			
//				dw_detail.setitem( li_cr,"street_2",dw_addresses.getitemstring( 1,"street_2"))
//			end if
//			if This.Describe("city.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"city",dw_addresses.getitemstring( 1,"city"))
//			end if
//			if This.Describe("state.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"state",dw_addresses.getitemnumber( 1,"state") )
//			end if
//			if This.Describe("zip.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"zip",dw_addresses.getitemstring( 1,"zip"))
//			end if
//			if This.Describe("county.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"county",dw_addresses.getitemnumber( 1,"county"))
//			end if
//			if This.Describe("country.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"country",dw_addresses.getitemnumber( 1,"country"))
//			end if
//			if This.Describe("phone.ColType") <> "!" then
//				//Start Code Change ----02.02.2009 #V92 maha - added if statement
//					//Start Code Change ----06.10.2008 #V81 maha - strip format characters
//				ls_phone = dw_addresses.getitemstring( 1,"phone") 
//				if this.describe("phone.EditMask.Mask") = "(###)###-####" then
//					ls_phone =  of_strip_char("", ls_phone, "@NUM@")
//				end if
//				
//				dw_detail.setitem( li_cr,"phone",ls_phone)
//					//End Code Change---06.10.2008
//				//End Code Change---02.02.2009
//			end if
//			if This.Describe("fax.ColType") <> "!" then
//				//Start Code Change ----02.02.2009 #V92 maha - added trap for formatted field
//				ls_phone = dw_addresses.getitemstring( 1,"fax") 
//				if this.describe("fax.EditMask.Mask") = "(###)###-####" then
//					ls_phone =  of_strip_char("", ls_phone, "@NUM@")
//				end if
//				dw_detail.setitem( li_cr,"fax",ls_phone)
//				//dw_detail.setitem( li_cr,"fax",dw_addresses.getitemstring( 1,"fax"))
//				//End Code Change---02.02.2009
//			end if
//			if This.Describe("e_mail_address.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"e_mail_address",dw_addresses.getitemstring( 1,"e_mail_address"))
//			end if
//			if This.Describe("web_address.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"web_address",dw_addresses.getitemstring( 1,"web_address"))
//			end if
//			if This.Describe("contact_person.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"contact_person",dw_addresses.getitemstring( 1,"contact_person"))
//			end if
//			if This.Describe("business_mgr.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"business_mgr",dw_addresses.getitemstring( 1,"business_mgr"))
//			end if
//			if This.Describe("office_mgr.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"office_mgr",dw_addresses.getitemstring( 1,"office_mgr"))
//			end if
//			if This.Describe("tax_id.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tax_id",dw_addresses.getitemstring( 1,"tax_id"))
//			end if
//			if This.Describe("tax_id_other_1.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tax_id_other_1",dw_addresses.getitemstring( 1,"tax_id_other_1"))
//			end if
//			if This.Describe("tax_id_other_2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tax_id_other_2",dw_addresses.getitemstring( 1,"tax_id_other_2"))
//			end if
//			if This.Describe("routine_visit_appt.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"routine_visit_appt",dw_addresses.getitemstring( 1,"routine_visit_appt"))
//			end if
//			if This.Describe("urgent_visit_appt.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"urgent_visit_appt",dw_addresses.getitemstring( 1,"urgent_visit_appt"))
//			end if
//			if This.Describe("emergency_visit_appt.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"emergency_visit_appt",dw_addresses.getitemstring( 1,"emergency_visit_appt"))
//			end if
//	
//			if This.Describe("handicapped_access.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"handicapped_access",dw_addresses.getitemnumber( 1,"handicapped_access"))
//			end if
//				if This.Describe("public_transportation.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"public_transportation",dw_addresses.getitemnumber( 1,"public_transportation"))
//			end if
//			if This.Describe("non_emergency_appt.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"non_emergency_appt",dw_addresses.getitemstring( 1,"non_emergency_appt"))
//			end if
//		
//			if This.Describe("mon_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"mon_from",dw_addresses.getitemstring( 1,"mon_from"))
//			end if
//			if This.Describe("mon_to.ColType") <> "!" then
//			dw_detail.setitem( li_cr,"mon_to",dw_addresses.getitemstring( 1,"mon_to"))
//			end if
//			if This.Describe("tue_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tue_from",dw_addresses.getitemstring( 1,"tue_from"))
//			end if
//			if This.Describe("tue_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tue_to",dw_addresses.getitemstring( 1,"tue_to"))
//			end if
//			if This.Describe("wed_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"wed_from",dw_addresses.getitemstring( 1,"wed_from"))
//			end if
//			if This.Describe("wed_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"wed_to",dw_addresses.getitemstring( 1,"wed_to"))
//			end if
//			if This.Describe("thu_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"thu_from",dw_addresses.getitemstring( 1,"thu_from"))
//			end if
//			if This.Describe("thu_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"thu_to",dw_addresses.getitemstring( 1,"thu_to"))
//			end if
//			if This.Describe("fri_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"fri_from",dw_addresses.getitemstring( 1,"fri_from"))
//			end if
//			if This.Describe("fri_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"fri_to",dw_addresses.getitemstring( 1,"fri_to"))
//			end if
//			if This.Describe("sat_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sat_from",dw_addresses.getitemstring( 1,"sat_from"))
//			end if
//			if This.Describe("sat_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sat_to",dw_addresses.getitemstring( 1,"sat_to"))
//			end if
//			if This.Describe("sun_from.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sun_from",dw_addresses.getitemstring( 1,"sun_from"))
//			end if
//			if This.Describe("sun_to.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sun_to",dw_addresses.getitemstring( 1,"sun_to"))
//			end if
//			if This.Describe("mon_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"mon_from2",dw_addresses.getitemstring( 1,"mon_from2"))
//			end if
//			if This.Describe("mon_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"mon_to2",dw_addresses.getitemstring( 1,"mon_to2"))
//			end if
//			if This.Describe("tue_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tue_from2",dw_addresses.getitemstring( 1,"tue_from2"))
//			end if
//			if This.Describe("tue_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"tue_to2",dw_addresses.getitemstring( 1,"tue_to2"))
//			end if
//			if This.Describe("wed_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"wed_from2",dw_addresses.getitemstring( 1,"wed_from2"))
//			end if
//			if This.Describe("wed_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"wed_to2",dw_addresses.getitemstring( 1,"wed_to2"))
//			end if
//			if This.Describe("thu_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"thu_from2",dw_addresses.getitemstring( 1,"thu_from2"))
//			end if
//			if This.Describe("thu_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"thu_to2",dw_addresses.getitemstring( 1,"thu_to2"))
//			end if
//			if This.Describe("fri_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"fri_from2",dw_addresses.getitemstring( 1,"fri_from2"))
//			end if
//			if This.Describe("fri_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"fri_to2",dw_addresses.getitemstring( 1,"fri_to2"))
//			end if
//			if This.Describe("sat_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sat_from2",dw_addresses.getitemstring( 1,"sat_from2"))
//			end if
//			if This.Describe("sat_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sat_to2",dw_addresses.getitemstring( 1,"sat_to2"))
//			end if
//			if This.Describe("sun_from2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sun_from2",dw_addresses.getitemstring( 1,"sun_from2"))
//			end if
//			if This.Describe("sun_to2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"sun_to2",dw_addresses.getitemstring( 1,"sun_to2"))
//			end if
//			if This.Describe("cust_1.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_1",dw_addresses.getitemstring( 1,"cust_1"))
//			end if
//			if This.Describe("cust_2.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_2",dw_addresses.getitemstring( 1,"cust_2"))
//			end if
//			if This.Describe("cust_3.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_3",dw_addresses.getitemstring( 1,"cust_3"))
//			end if
//			if This.Describe("cust_4.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_4",dw_addresses.getitemstring( 1,"cust_4"))
//			end if
//			if This.Describe("cust_5.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_5",dw_addresses.getitemstring( 1,"cust_5"))
//			end if
//			if This.Describe("cust_6.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"cust_6",dw_addresses.getitemstring( 1,"cust_6"))
//			end if
//			//Start Code Change ---- 12.21.2006 #V7 maha
//			if This.Describe("suite_apart.ColType") <> "!" then
//				dw_detail.setitem( li_cr,"suite_apart",dw_addresses.getitemstring( 1,"suite_apart"))
//			end if
//			//End Code Change---12.21.2006
//			inv_data_entry.of_set_defaults( This, This.RowCount() )
//		END FOR	
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2005-04-10 By: owen chen
//		//$<reason> Performance tuning modification
//		//$<reason> Reduce the frequency of client-server interactions to improve runtime performance 
// 
// 		ib_addaddress = false
//		
//		dw_link_list.retrieve(il_addr_id)
//		
//		int li_retval
//		li_retval = parent_window.Event Pfc_Save( )
//		IF li_retval < 0 THEN
//			This.PostEvent( "pfc_cst_after_error" )
//		END IF
//		
//		//---------------------------- APPEON END ----------------------------
//		
//		if gi_temp_switch = 0 then //maha 083004 when adding	
//			IF li_address_cnt > 0 THEN
//				dw_browse.scrolltorow(dw_browse.rowcount()) //maha 012704
//				dw_browse.setrow(dw_browse.rowcount())
//				dw_browse.selectrow(0,false)
//				dw_browse.selectrow(dw_browse.rowcount(),true)
//				if li_address_cnt > 1 THEN
//					MessageBox("Reminder", "Go to each Address record and set up the Address Link data." )
//				end if
//			END IF
//						
//			dw_link_list.Retrieve( dw_detail.GetItemNumber( dw_detail.GetRow( ), "rec_id")  )
//		else //when updating
//			gi_temp_switch = 0
//			
//		end if
//
//	else //old find function based on addresses
//		This.GetChild( "street", dwchild )
//		dwchild.SetTransObject( SQLCA )
//		dwchild.Retrieve( "%" + This.GetText() + "%" )
//		//This.SetText( "" )
//	end if
//
//
//	
//ELSEIF dwo.Name = "populatebutton" THEN //used with old find function
//
//	Integer li_row_cnt
//	String ls_rec_id	
//	String ls_grey
//	String ls_presentation_str
//	String ls_dwsyntax_str
//	String ERRORS
//	String ls_syntax
//	
//	ls_syntax = is_sql_syntax
//	
//
//	This.AcceptText()
//	ls_rec_id = This.GetItemString( row, "street" ) 
//	
//	///Start Code Change ----.2010 #V10 maha/--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 06.30.2006 By: Liang QingShi
//	//$<reason> Fix a bug
//	if long(ls_rec_id) <= 0 then return -1
//	//---------------------------- APPEON END ----------------------------
//
//	ls_syntax = ls_syntax + " WHERE pd_address.rec_id = " + ls_rec_id
//	
//	ls_grey = String(rgb(192,192,192))
//	ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  
//
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_syntax, &
//		ls_presentation_str, ERRORS)
//
//	IF Len(ERRORS) > 0 THEN
//		MessageBox("Caution", &
//		"SyntaxFromSQL caused these errors: " + ERRORS)
//		RETURN -1
//	END IF
//
//	dw_addresses.Create( ls_dwsyntax_str, ERRORS)
//
//	IF Len(ERRORS) > 0 THEN
//		MessageBox("Caution", &
//		"Create cause these errors: " + ERRORS)
//		RETURN -1
//	END IF
//	
//	dw_addresses.of_SetTransObject( SQLCA )
//	li_row_cnt = dw_addresses.Retrieve(  )
//	IF li_row_cnt = 0 THEN
//		MessageBox("Error", "Nothing to select.")
//		Return -1
//	END IF
//
//	This.DeleteRow( row )
//	
//	dw_addresses.RowsCopy ( 1, 1, Primary!, This, 1000, Primary! )
//
//	This.ScrollToRow( This.RowCount() )
//	This.SetRow( This.RowCount() )	
//	
//	This.AcceptText()
//
//	This.GetChild( "street", dwchild )
//	dwchild.Reset()
////\/maha 062801  peer lookup select
//elseif dwo.Name = "peerbutton" THEN
//	//------------------- APPEON BEGIN -------------------
//	//$<modify> 03.10.2009 By: Evan
//	//$<reason> Peer reference new feature
//	/*
//	long ll_peer_id
//	integer p
//	open(w_select_peer)
//	ll_peer_id = message.doubleparm
//	IF ll_peer_id < 1 THEN  //Start Code Change ----02.28.2008 #V8 maha  - IF ll_peer_id = 0 THEN
//		Return
//	END IF
//	//messagebox("ll_peer_id",ll_peer_id)
//	
//	dw_addresses.dataobject = "d_peer_lu_select"
//	dw_addresses.SetTransObject( SQLCA )
//	p = dw_addresses.Retrieve( ll_peer_id )
//	
//	//Start Code Change ----02.28.2008 #V8 maha  - trap for bad retrieval
//	if p < 1 then
//		messagebox("Peer Populate","Unable to get the selected peer data.")
//		return
//	end if
//	//End Code Change---02.28.2008
//	
//	li_cr = dw_detail.GetRow()
//
//	if This.Describe("title.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"title", long(dw_addresses.getitemstring( 1,"contact_salutation")))
//	end if
//	if This.Describe("last_name.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"last_name",dw_addresses.getitemstring( 1,"entity_name"))
//	end if
//	if This.Describe("first_middle_name.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"first_middle_name",dw_addresses.getitemstring( 1,"street2"))
//	end if
//	if This.Describe("name_suffix.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"name_suffix",long(dw_addresses.getitemstring( 1,"web_address")))
//	end if
//	if This.Describe("prof_suffix.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"prof_suffix",long(dw_addresses.getitemstring( 1,"contact_name")))
//	end if
//	if This.Describe("street.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"street",dw_addresses.getitemstring( 1,"street1"))
//	end if
//	if This.Describe("city.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"city",dw_addresses.getitemstring( 1,"city"))
//	end if
//	if This.Describe("state.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"state",long(dw_addresses.getitemstring( 1,"state") ))
//	end if
//	if This.Describe("zip.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"zip",dw_addresses.getitemstring( 1,"zip"))
//	end if
//	if This.Describe("country.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"country",long(dw_addresses.getitemstring( 1,"country")))
//	end if
//	if This.Describe("cust_5.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"cust_5",dw_addresses.getitemstring( 1,"phone"))
//	end if
//	if This.Describe("cust_1.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"cust_1",dw_addresses.getitemstring( 1,"custom_3"))
//	end if
//	if This.Describe("cust_2.ColType") <> "!"  then
//		dw_detail.setitem( li_cr,"cust_2",dw_addresses.getitemstring( 1,"custom_4"))
//	end if
////	s = This.Describe("cust_3") 
////	messagebox("s",s)
//	if This.Describe("cust_3.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"cust_3",dw_addresses.getitemstring( 1,"custom_5"))
//	end if
//	//Start Code Change ---- 04.11.2007 #V7 maha
//	if This.Describe("fax.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"fax",dw_addresses.getitemstring( 1,"fax"))
//	end if
//	if This.Describe("e_mail_address.ColType") <> "!" then
//		dw_detail.setitem( li_cr,"e_mail_address",dw_addresses.getitemstring( 1,"email_address"))
//	end if
//	//End Code Change---04.11.2007	
////\maha	
//	*/
//	OpenWithParm(w_peer_reference_select, this)
//	//------------------- APPEON END ---------------------
//ELSEIF dwo.Name = "imgbutton" THEN //SK Practitioner Folder - alfee 09.10.2010
//	if of_get_app_setting("image_storage_type","I") = 0 then//Start Code Change ----05.11.2011 #V11 maha - trap for images on hard drive
//		messagebox("View Images","This functionality is only available if your images are stored in the database.  Please view your images from the Documents tab.~r~rContact ISG support for assistance in migrating your images to the database.")
//		return
//	end if
//	IF il_prac_id > 0 and ii_screen_id > 0 THEN
//		OpenwithParm(w_image_preview, string(il_prac_id) + '||' + string(ii_screen_id))
//	END IF		
//ELSEIF dwo.Name = "gapbutton" THEN  //Start Code Change ----12.02.2010 #V10 maha - Work Gap Calculate
//	of_calc_work_gap(il_prac_id)
//END IF
//
//
end event

event constructor;This.of_SetRowManager( TRUE )
//This.inv_rowmanager.of_SetRestoreRow( TRUE )
//This.inv_rowmanager.of_SetConfirmOnDelete ( TRUE )
This.of_SetReqColumn(TRUE)



end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-08-12 By: Scofield
//$<Reason> Popup a dialog to input the phone.

String	ls_Name,ls_Mask,ls_Phone,ls_RetParm
long		ll_FieldID

if row > 0 and row <= This.RowCount() then
	ls_Name = dwo.name
	ll_FieldID = long(This.Describe(ls_Name + ".Tag"))
	
	SELECT field_mask INTO :ls_Mask FROM sys_fields WHERE field_id = :ll_FieldID and field_name = :ls_Name ;
	
	//if Trim(ls_Mask) = "(###)###-####" then
	if Trim(ls_Mask) = "INTPHONE" then  //Start Code Change ----02.02.2009 #V92 maha
	
		if gi_user_readonly = 1 then return  //alfee 12.30.2009
		
		If Long(This.Describe(ls_Name + ".TabSequence")) = 0 Then Return //Added by Appeon long.zhang 03.31.2016 (bug id 5075 phone format issue)
				
		ls_Phone = This.GetItemString(row,ls_Name)
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,ls_Name,ls_RetParm)
		end if
		This.SetColumn(ls_Name)
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;//String ls_type
//Integer li_screen
//Integer li_ans
//Integer li_stat
//Long ll_rec_id
//
//
////IF inv_data_entry.of_itemchanged( This, Data ) = 1 THEN //this function buts a dot on the basic info middle name if only 1 character
////	RETURN 2
////END IF
//
////Start Code Change ----08.01.2008 #V85 maha - modified active status to use function call rewrote to test only on existing records
//IF This.GetColumnName() = "active_status" And This.GetItemStatus( row, 0, primary!) <> newmodified! THEN //Start Code Change ----08.01.2008 #V85 maha - change to run only if not  a new record - changed to <> newmodified 02.02.2008
//	li_stat = Integer(Data)
//	if ii_screen_id <> 2 then //Start Code Change ----02.02.2009 #V92 maha - trap for address screen	
//		IF li_stat = 0 THEN //if inactive display message
//			li_ans = MessageBox( "Active Status", "If you change this active status to INACTIVE, all verification entries for this record will be Permanently changed to inactive.  Continue?", Question!, YesNo!, 1 )
//			IF li_ans = 1 THEN
//				li_ans = MessageBox("Active Status", "Are you sure?", Question!, YesNo!, 1	)
//				IF li_ans = 2 THEN //if no set active
//					This.SetItem(row,This.GetColumn( ),1 )
//					RETURN
//				END IF
//			END IF
//		END IF
//		
//		ll_rec_id = This.GetItemNumber( row, "rec_id" )
////		parent_window.inv_action_items.of_update_verif_status(  ll_rec_id, ii_screen_id , li_stat  )
//	end if
//	//	IF data = "0" THEN
//	//		Integer li_ans
//	//		Long ll_rec_id
//	//		li_ans = MessageBox( "Active Status", "If you change this active status to INACTIVE, all verification entries for this record will be Permanently changed to inactive.  Continue?", StopSign!, YesNo!, 1 )
//	//		IF li_ans = 1 THEN
//	//			li_ans = MessageBox("Active Status", "Are you sure?", StopSign!, YesNo!, 1 )
//	//			IF li_ans = 1 THEN
//	//				ll_rec_id = This.GetItemNumber( row, "rec_id" )
//	//				UPDATE verif_info  
//	//			     SET active_status = 0 
//	//				WHERE rec_id = :ll_rec_id;
//	//				IF SQLCA.SQLCODE = -1 THEN
//	//					MessageBox("Database Error", SQLCA.SQLERRTEXT )
//	//				END IF
//	//			END IF
//	//		END IF
//	//	END IF
//	
//END IF
////End Code Change---08.01.2008
//
////tab_view.tabpage_image.Enabled = True
//
////maha 061605 for lookup search
//
//IF Long(Data) = -777 THEN
//	ls_type = "C"
//	AcceptText( )
//	This.PostEvent( "ue_after_itemchanged",0,ls_type)
//ELSEIF Long(Data) = -888 THEN
//	ls_type = "A"
//	AcceptText( )
//	This.PostEvent( "ue_after_itemchanged",0,ls_type )
////	inv_data_entry.of_refresh_cache( ) //maha 122205
//END IF
//
//
end event

event itemfocuschanged;call super::itemfocuschanged;

//IF This.Describe(This.GetColumnName() + ".DDDW.DisplayColumn") = "entity_name"  THEN
DataWindowChild dwchild
String ls_column_name
integer res	
	
	ls_column_name =This.GetColumnName()
	res = This.GetChild( ls_column_name, dwchild )
	if res > 0 then
		IF dw_select_section.GetRow()>0 Then//Added by  Nova 06.17.2010
			if dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id") = 65 or dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id") = 54 or ls_column_name = "billing_address_id" then //maha app081705 trap for question dddw
				//nothing
			else
				IF dwchild.RowCount() > 2 THEN //maha changed from 1 for lookup search 061605
					//--------------------------- APPEON BEGIN ---------------------------
					//$<add> 04.19.2006 By: LeiWei
					//$<reason> Fix a defect.
					/*
					is_lookup_search_column_table = dwchild.GetItemString( 3, "lookup_name" )//maha changed from 2 for lookup search 061605 //Start Code Change ---- 06.08.2006 #528 maha
					*/
	//				IF ls_column_name <> "street" THEN
					IF ls_column_name <> "street" and ls_column_name <> "active_status" THEN  //Start Code Change ----07.23.2008 #V85 maha - added active_status exception
						is_lookup_search_column_table = dwchild.GetItemString( 3, "lookup_name" )//maha changed from 2 for lookup search 061605
					END IF
					//---------------------------- APPEON END ----------------------------
				END IF
			end if
		END IF	
	end if
	IF IsValid( m_pfe_cst_data_entry ) THEN
		m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
	END IF
//ELSE
//	IF IsValid( m_pfe_cst_data_entry ) THEN
//		m_pfe_cst_data_entry.m_edit.m_lookupsearch.enabled = False
//	END IF
//END IF

IF This.GetColumnName() = "billing_address_id" THEN
	This.GetChild( "billing_address_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( il_prac_id )
	
	dwchild.InsertRow( 1 )
	dwchild.SetItem( 1, "pd_address_street", "N/A" )	
	dwchild.SetItem( 1, "pd_address_city", "" )
	dwchild.SetItem( 1, "code_lookup_code", "" )
	dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
	dwchild.InsertRow( 1 )
	dwchild.SetItem( 1, "pd_address_street", "Same" )	
	dwchild.SetItem( 1, "pd_address_city", "" )
	dwchild.SetItem( 1, "code_lookup_code", "" )
	dwchild.SetItem( 1, "pd_address_rec_id", 0 )
	dwchild.InsertRow( 1 )
	dwchild.SetItem( 1, "pd_address_street", "" )	
	dwchild.SetItem( 1, "pd_address_city", "" )
	dwchild.SetItem( 1, "code_lookup_code", "" )	
END IF


end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.21.2006 By: Leiwei
//$<reason> Fix a defect.

/* colname = this.getcolumnname() */
colname = dwo.name
//---------------------------- APPEON END ----------------------------

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event resize;call super::resize;//alfee 05.12.2010

choose case ii_screen_id
	case 10,2,19 //address, hospital, specialty
	//	post of_detail_scrollbar(ii_screen_id) //resize the detail dw
	case else
		//
end choose
end event

event retrieveend;call super::retrieveend;if This.Describe("prac_id.ColType") <> "!" then //maha 051503 for lehigh
	this.Modify("prac_id.background.color = '12632256'")
	//this.Modify( "prac_id.TabSequence = 0" )
	//this.Modify( "prac_id.protect = 1" )
	//this.Modify( "prac_id.x = '2100'" )
	//this.Modify( "prac_id.y = '100'" )
end if

if This.Describe("rec_id.ColType") <> "!" then //maha 051503 
	this.Modify("rec_id.background.color = '12632256'")
	//this.Modify( "rec_id.TabSequence = 0" )
	//this.Modify( "rec_id.protect = 1" )
	//this.Modify( "prac_id.x = '2100'" )
	//this.Modify( "prac_id.y = '100'" )
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06/10/2008 By: Ken.Guo
//$<reason> Move script to function of_set_page_menu()
/*
// mskinner 13 Dec 2005 -- begin
if isvalid(m_pfe_cst_data_entry) then 
if this.rowcount() > 1 then 
 m_pfe_cst_data_entry.m_view.m_priorpage.enabled = true
 m_pfe_cst_data_entry.m_view.m_nextpage.enabled = true
else 
 m_pfe_cst_data_entry.m_view.m_priorpage.enabled = false
 m_pfe_cst_data_entry.m_view.m_nextpage.enabled = false
end if 
end if
// mskinner 13 Dec 2005 -- end
*/
//of_refresh_page_menu() //Added By Ken.Guo 06.10.2008
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanged;call super::rowfocuschanged;//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())

IF currentrow > 0 THEN
//	of_get_record_verif( currentrow )
	dw_browse.SelectRow( 0, False )
	dw_browse.SelectRow( currentrow, True )
	dw_browse.SetRow( currentrow )
	dw_browse.ScrollToRow( currentrow )
//	if ib_report=false then
		if this.rowcount() > 0 then
			il_rec_id = This.GetItemNumber( currentrow, "rec_id" )
		end if
//	end if
END IF
end event

event rowfocuschanging;call super::rowfocuschanging;//IF is_screen_name = "Address" AND dw_link_list.GetItemStatus( dw_link_list.GetRow(), 0, Primary!)  = DataModified! THEN 
//IF ii_screen_id = 2 AND dw_link_list.GetItemStatus( dw_link_list.GetRow(), 0, Primary!)  = DataModified! THEN 
//	IF of_address_link_check() = -1 THEN
//		Return 1
//	ELSE
//		dw_link_list.Update()
//	END IF
//END IF
end event

event scrollvertical;call super::scrollvertical;Long ll_numrow
String ls_firstrow, ls_lastrow

ls_lastrow = This.Object.Datawindow.LastRowOnPage
ll_numrow = dw_browse.GetItemNumber(Long(ls_lastrow),"rec_id")
dw_link_list.Retrieve(ll_numrow) //
RETURN 0

end event

event pfc_deleterow;//Return of_delete_record( This )
return 0


end event

event pfc_addrow;call super::pfc_addrow;//Integer li_retval
//integer cnt
//long ll_appt_id
//
////tab_view.tabpage_image.Enabled = False
//if ii_screen_id = 65 or ii_screen_id = 54 then //maha app081705 questions//Start Code Change ---- 06.08.2006 #529 maha
//	this.deleterow( this.rowcount()) //delete the just added row
//	//Start Code Change ----06.17.2009 #V92 maha - changed to hit db once
////	select count(rec_id) into :cnt from pd_affil_stat where prac_id = :gl_prac_id and parent_facility_id = :ii_parent_facility_id and active_status > 0;
////	if cnt < 1 then
////		messagebox("Appointment record error","There are no non-history records (Active,Inactive,Pending,Purge) for this practitioner and facility.  This should be corrected on the Appointment Status tab before adding Attestation Questions.")
////		return - 1 
////	else
//		select top 1 rec_id into :ll_appt_id from pd_affil_stat where prac_id = :gl_prac_id and parent_facility_id = :ii_parent_facility_id and active_status > 0;  
////	end if	
//
//	If isnull(ll_appt_id) or ll_appt_id = 0 then
//		messagebox("Appointment record error","There are no active records for this practitioner and facility. As questions are directly connected to the Appointment record, unable to add Questions.")
//		return - 1 
//	end if
//	//End Code Change---06.17.2009
//	//Start Code Change ---- 06.08.2006 #529 maha
//	if ii_screen_id = 65 then
//		inv_data_entry.of_add_questions("PRAC",dw_detail,ii_parent_facility_id,gl_prac_id,ll_appt_id)
//	elseif  ii_screen_id = 54  then //practice questions
//		inv_data_entry.of_add_questions("PQ",dw_detail,ii_parent_facility_id,gl_prac_id,ll_appt_id)
//	end if
//	//End Code Change---06.08.2006
//else
//	inv_data_entry.of_set_defaults( This, This.RowCount() )
//	This.SetItemStatus( This.RowCount(), 0, Primary!, NotModified! )
//end if
//
//this.scrolltorow(This.RowCount()) //maha app100305
//This.SetColumn( is_first_column_detail_1 )
//This.SetFocus()
//
//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
//of_refresh_page_menu() //Added By Ken.Guo 06.10.2008
//
RETURN 0
end event

event pfc_retrieve;call super::pfc_retrieve;

Return This.Retrieve( )
end event

event pfc_nextpage;return this.ScrollNextRow() //Added By Ken.Guo 06.06.2008
end event

event pfc_previouspage;return this.ScrollPriorRow() //Added By Ken.Guo 06.06.2008
end event

event pfc_validation;call super::pfc_validation;//Integer li_retval
//integer li_table_id
//
////Start Code Change ----06.18.2008 #V81 maha - removed. now called from of_validate in dw_detail
//if this.rowcount() < 1 then return 1
//li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
//li_retval = of_validate( li_table_id, this.getrow())
////li_retval = inv_data_entry.of_record_validation( This )
//IF li_retval = -1 THEN
//	Return -1
//END IF
////End Code Change---06.16.2008

Return AncestorReturnValue

end event

event pfc_postupdate;////Start Code Change ----08.06.2009 #V92 maha - readded with security
//if w_mdi.of_security_access(40) = 2 or w_mdi.of_security_access(50) = 2 then
//	m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True //maha removed 082503
//end if
////End Code Change---08.06.2009
//
//This.ScrollToRow( il_last_de_row )
//This.SetRow( il_last_de_row )
//
////setting green checkmark screen icon
//integer r
//
//dwItemStatus l_Status
//l_Status = this.getitemstatus(1,0,primary!)
//
//r = this.rowcount()
//if r > 1 then
//	dw_select_section.setitem(dw_select_section.getrow(),"selected",r)
////Start Code Change ----09.22.2010 #V10 maha - modified to make work
//elseif l_Status = new! or IsNull(l_Status)  then
//	dw_select_section.setitem(dw_select_section.getrow(),"selected",0)
//else
//	dw_select_section.setitem(dw_select_section.getrow(),"selected",1)
//end if
////Start Code Change ----09.22.2010
////---------------------------- APPEON END ----------------------------
//
////Added for Work Flow trigger. 11.21.2006 Henry
//string ls_module
//long ll_screen_id[]  //12.13.2006 By Jervis
//
//If of_Get_app_setting("set_9" , "I") = 1 Then
//	ls_module = '02'
//Else
//	ls_module = '01'
//End if
//If gb_workflow Then
//	n_cst_workflow_triggers lnv_workflow
//	lnv_workflow = create n_cst_workflow_triggers
//	
//	If parent_window.ib_new_prac Then ii_parent_facility_id = 1
//	//12.13.2006 By Jervis
//	ll_screen_id[1] = ii_screen_id
//	//lnv_workflow.of_data_value_comparision( ii_screen_id, il_prac_id, ii_parent_facility_id, ls_module, 'I')
//	lnv_workflow.of_data_value_comparision( ll_screen_id, il_prac_id, ii_parent_facility_id, ls_module, 'I')
//	//12.13.2006 End
//
//	Destroy lnv_workflow
//	
//	//Refresh Action Item Data
//	if ls_module = "02" then
//		parent_window.of_retrieve_net( )
//	end if
//End If
////End added 11.21.2006
//
////run data flow if any - dataflow: alfee 12.24.2009
//inv_dataflow.of_run_data_flow()
//
////
//// Add by andy 01/29/2010 V10.1 - Notification Alert
////
//String	ls_table_name
//n_cst_notification_alert_upd	lnv_na
//
//ls_table_name = This.Object.DataWindow.Table.UpdateTable
//lnv_na.of_update_alert_records(ls_table_name, This)
//
//// Because I must check column status in the above function,
//// I unextend ancestor script and call it at last.
//Call Super::pfc_postupdate
//
Return 1
//
end event

event pfc_preupdate;call super::pfc_preupdate;////this is the preupdate being used
//
//DateTime ldt_exp_date
//DateTime ldt_null_date
//DateTime ldt_exp_date_original
//Long ll_rec_id
//Long ll_address_code
//long ll_appt_stat_recid  //#1 maha 101606
//long ll_templ_id[ ]  //#1 maha 101606
//long ll_verif_response  //#1 maha 101606  completion response code for verif; if 0 will not be completed.
//long li_seq_no
//long li_found
//Long ll_new_cnt //Added By Ken.Guo 03.31.2008
//Long ll_rec_id_new //Added By Ken.Guo 05.29.2008. Replace il_rec_id
//Long ll_rec_id_changed[]
//Integer li_table_id
//Integer li_facility_specific
//Integer li_screen_id
//Integer li_current_row
//Integer i
//Integer li_cnt
//Integer li_rec_count
//Integer li_data_cr
//Integer li_verif_rc
//Integer li_retval
//integer li_year //maha031601
//integer li_month//maha031601
//integer li_validate//maha080803
//integer li_res //maha 032406
//integer li_complete[ ] //#1 maha 101606
//integer li_auto_gen[ ] //#1 maha 101606
//integer li_app_audit_facil //#1 maha 101606
//integer li_appt_stat //#1 maha 101606
//integer li_temp_cnt //#1 maha 101606
//integer li_status = 1 //maha 080108
//integer t  //#1 maha 101606
//integer li_set_mess //maha 05.05.2009
//
//string ls_use_as_ver //#1 maha 101606
//String ls_screen_name
//String ls_ref_1
//String ls_val
//String ls_ref_2
//String ls_ref_3
//String ls_exp_field
//String ls_reference
//String ls_rec_status
//string ls_app_type //#1 maha 101606
//string ls_mess //#1 maha 101706
//string ls_type1//maha102501
//string ls_type2//maha102501
//string ls_type3//maha102501
//DataWindowChild dwchild
//n_ds lds_aa_template //#1 maha 101606
//
//SetNull( ldt_null_date )
//This.AcceptText()
//
////initialize variables for dataflow: alfee 01.07.2010
//inv_dataflow.of_init_data() 
//
//li_rec_count = This.RowCount()
//IF li_rec_count < 1 THEN
//	IF ib_deleting THEN
//		RETURN 1
//	ELSE
//		RETURN -1
//	END IF
//END IF
//
//SetRedraw( False )
//
//il_last_de_row = This.GetRow()
//li_data_cr = This.GetRow()
//
//ls_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
//ls_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
//ls_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")
//ls_type1 = dw_select_section.GetItemString( il_last_row, "ref_1_type")//maha102501
//ls_type2 = dw_select_section.GetItemString( il_last_row, "ref_2_type")//maha102501
//ls_type3 = dw_select_section.GetItemString( il_last_row, "ref_3_type")//maha102501
//
//ls_exp_field = dw_select_section.GetItemString( il_last_row, "exp_field")
//li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
//ls_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")
//li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
//li_set_mess = of_get_app_setting("set_57","I")  //Start Code Change ----05.04.2009 #V92 maha
//li_validate  = Long(gnv_data.of_getitem( "sys_fields", "field_id", "table_id = "+String(li_table_id)+" and use_validation > 0"))
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-30
////$<add> 03.16.2006 By: Liang QingShi
////$<reason> Performance tuning
////$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
////$<modification> value into database.
//ll_new_cnt = 0
//FOR i = 1 TO li_rec_count
//	IF This.GetItemStatus( i, 0, Primary!)  = NewModified! THEN
//		ll_new_cnt++
//	//Start Code Change ----05.04.2009 #V92 maha - inova mod; if basic data has changed, ask before saving
//	elseif This.GetItemStatus( i, 0, Primary!)  = DataModified! THEN
//		if li_screen_id = 1 and li_set_mess = 1 then 
//			li_res = messagebox("Data Modified","The data on this screen has been modified.  Do you wish to save changes?",question!, yesno!,2)
//			if li_res = 2 then
//				SetRedraw( True ) 
//				return 100
//			end if
//		end if
//		//End Code Change---05.04.2009
//	End IF
//END FOR
//If ll_new_cnt > 0 Then
//	ll_rec_id_new = gnv_app.of_Get_Id("RECORD_ID" , ll_new_cnt) - 1
//	If ll_rec_id_new < 0 Then //Added By Ken.Guo 04.24.2008.
//		Messagebox('Error','Failed to get Record_ID value, Please call support.')
//		SetRedraw( True ) 
//		Return -1
//	End If
//End If
////---------------------------- APPEON END ----------------------------
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-25
////$<add> 2006-04-11 By: owen chen
////$<reason> Performance tuning modification
////$<modification> Use ids_parent_facilities to retrive all data
////$<modification> to be used by pfc_cst_u_data_entry. 
//ids_parent_facilities = CREATE n_ds
//ids_parent_facilities.DataObject = "d_address_link_parent_facility_id"
//ids_parent_facilities.of_SetTransObject( SQLCA )
//ids_parent_facilities.Retrieve( il_prac_id )
////---------------------------- APPEON END ----------------------------
////@@@@@@@@
////Start Code Change ---- 10.25.2006 #1 maha  getting values for app audit creation
//ids_parent_facilities.setfilter("parent_facility_id = " + string(ii_parent_facility_id) + " and active_status in (1,4)")
//ids_parent_facilities.filter()
//li_app_audit_facil =  ids_parent_facilities.rowcount()
////select count(rec_id) into :li_app_audit_facil from pd_affil_stat where prac_id = :il_prac_id and parent_facility_id = :ii_parent_facility_id and active_status in (1,4);
//if li_app_audit_facil > 1 then
//	li_app_audit_facil = -1 //trap if there is improper data
//elseif li_app_audit_facil = 1 then //normally should be one
//	//get the template items for the screen
//	lds_aa_template = CREATE n_ds
//	lds_aa_template.DataObject = "d_app_audit_by_facility_screen"
//	lds_aa_template.of_SetTransObject( SQLCA )
//	ls_app_type = ids_parent_facilities.getitemstring(1,"apptmnt_type")
//	li_app_audit_facil = ids_parent_facilities.getitemnumber(1,"application_audit_facility")
//	ll_appt_stat_recid = ids_parent_facilities.getitemnumber(1,"rec_id")
//	li_temp_cnt = lds_aa_template.Retrieve(li_app_audit_facil ,ii_screen_id,ls_app_type)
//	if li_temp_cnt < 1 then
//		li_auto_gen[i] = 0
//		li_complete[i] = 0
//		ls_use_as_ver = "N"
//		ll_verif_response = 0
//	else //WHAT ABOUT MULTIPLES?
//		for i = 1 to li_temp_cnt  //get each auto gen item
//			ll_templ_id[i] = lds_aa_template.getitemnumber(i,"app_audit_id")
//			li_auto_gen[i] = lds_aa_template.getitemnumber(i,"auto_generate")
//			if isnull(li_auto_gen[i]) then li_auto_gen[i] = 0
//			li_complete[i] = lds_aa_template.getitemnumber(i,"receive_from_de")
//			if isnull(li_complete[i]) then li_complete[i] = 0
//			if ls_use_as_ver <> "Y" then //if not already set to use as verification
//				ls_use_as_ver = lds_aa_template.getitemstring(i,"use_as_verification")
//				if isnull(ls_use_as_ver) then ls_use_as_ver = "N"
//			end if
//			if ll_verif_response = 0 or isnull(ll_verif_response) then //get response code if not set
//				ll_verif_response = lds_aa_template.getitemnumber(i,"default_ver_response_code")
//				if isnull(ll_verif_response) then ll_verif_response = 0
//			end if
//		next
//		if ls_use_as_ver = "Y" then
//			ls_mess = "Y"
//		else
//			ls_mess = "N"
//		end if
//		ls_mess = ls_mess +  "*" +string(ll_verif_response )
//	end if
//end if
////w_app_audit_complete_mes
//ids_parent_facilities.setfilter("") //reset the filter
//ids_parent_facilities.filter()
////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
////End Code Change---10.25.2006
//
//FOR i = 1 TO li_rec_count
//	//debugbreak()			
//	SetNull( ll_address_code )
//	IF This.GetItemStatus( i, 0, Primary!) <> NewModified! AND +&
//		This.GetItemStatus( i, 0, Primary!) <> DataModified! THEN
//		CONTINUE
//	ELSEIF This.GetItemStatus( i, 0, Primary!)  = NewModified! THEN
//		ls_rec_status = "New"
//		ll_rec_id_new ++
//		This.SetItem( i, "prac_id", il_prac_id)
//		IF li_screen_id = 61 or li_screen_id = 32 or li_screen_id = 33 THEN		
//			SELECT pd_affil_stat.rec_id  
//    		INTO :ll_rec_id_new  
//    		FROM pd_affil_stat  
//   		WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
//         		( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) AND  
//         		( pd_affil_stat.active_status in (1,4) )   ;  //maha  changed to include pending 072402
//			IF SQLCA.SQLCODE = -1 THEN
//				MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
//				Return -1
//			END IF
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 05/05/2008 By: Ken.Guo
//			//$<reason> Fix BugK050504.Duplicate PK when save staff category data.
//			//li_seq_no = inv_data_entry.of_get_next_seq_no( "department", il_rec_id )
//			Choose Case li_screen_id
//				Case	32 //Depart/Div/Section
//					li_seq_no = inv_data_entry.of_get_next_seq_no( "department", ll_rec_id_new )
//				Case	33 //Staff Category
//					li_seq_no = inv_data_entry.of_get_next_seq_no( "staff cat", ll_rec_id_new )
//				Case	61 //No this screen id in DB???
//					li_seq_no = inv_data_entry.of_get_next_seq_no( "department", ll_rec_id_new )
//			End Choose
//			//---------------------------- APPEON END ----------------------------
//			li_seq_no++
//			This.SetItem( i, "seq_no", li_seq_no )				
//			This.SetItem( i, "rec_id", ll_rec_id_new )			
//		ELSE
//			This.SetItem( i, "rec_id", ll_rec_id_new )			
//		END IF
//		IF li_screen_id = 2 then //Upper(ls_screen_name) = "ADDRESS" THEN
//			of_add_address_link( ll_rec_id_new )
//		elseIF ii_screen_id = 10 THEN		// "HOSPITAL AFFILIATION"
//			of_add_hosp_link( ll_rec_id_new )
//		elseIF ii_screen_id = 19 THEN			//"BOARD/SPECIALTY"
//			of_add_spec_link( ll_rec_id_new )
//		END IF
//		
//	ELSE
//		ls_rec_status = "Modified"
//	END IF
//	
//	ll_rec_id = This.GetItemNumber( i, "rec_id" )
//	
//	//Start Code Change ----07.14.2010 #V10 maha - removed the screen qualification so any other screens with active status will work
////	IF ii_screen_id = 4 OR ii_screen_id = 15 OR ii_screen_id = 5 THEN
//		IF This.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
//			//IF This.GetItemNumber( i, "active_status" ) = 0 THEN
//			IF This.GetItemNumber( i, "active_status" ) < 1 THEN  //Start Code Change ----01.24.2011 #V11 maha - changd from = 0
//				if ls_rec_status = "New" then
//					CONTINUE
//				else				//\/maha 031601  //Start Code Change ----01.24.2011 #V11 maha - modified update query to include prac_id
//					update verif_info
//					set active_status = 0
//					where rec_id = :ll_rec_id and prac_id = :il_prac_id and active_status = 1;
//					continue		 //\maha
//				end if
//			END IF
//		END IF
////	END IF	
//	//End Code Change ----07.14.2010
//	
//	//\/maha 031601 get month and year end for check back date passed in verification add
//	IF li_screen_id  = 7 or li_screen_id = 10 THEN  // training & hosp affil
//		if This.Describe("year_thru.ColType") <> "!" then
//			li_year = this.getitemnumber(i,"year_thru")
//			if This.Describe("month_thru.ColType") <> "!" then
//				li_month = this.getitemnumber(i,"month_thru")
//			end if
//			//maha added to using full end date field
//		//--------Begin Modified by  Nova 07.15.2010------------------------
//		//elseif This.Describe("end _date.ColType") <> "!" then    
//		elseif This.Describe("end_date.ColType") <> "!" then    
//		//--------End Modified --------------------------------------------	
//			li_year = year(date(this.getitemdatetime(i,"end_date")))
//			li_month = month(date(this.getitemdatetime(i,"end_date")))
//		end if
//	end if
//	//\maha
//		
//	li_facility_specific = Long(gnv_data.of_getitem( "sys_tables", "facility_specific", "table_id = "+String(li_table_id) ))
//	
//	IF li_screen_id = 19 THEN //specialty
//		if This.Describe("board_code.ColType") = "!" then continue //Start Code Change----06.01.2010 #V10 maha - added trap for hidden board code
//		
//		IF IsNull( This.GetItemNumber( i, "board_code" ) ) THEN
//			CONTINUE
//		  //Start Code Change ---- 10.26.2007 #V7 maha	
//		ELSE
//			ll_address_code = This.GetItemNumber( i, "board_code" ) 
//			IF ls_rec_status = "Modified" THEN
//		//ELSEIF ls_rec_status = "Modified" THEN
//				SELECT count(*)  
//				INTO :li_cnt  
//						FROM verif_info  
//						WHERE ( verif_info.rec_id = :ll_rec_id ) AND  
//							( verif_info.active_status = 1 )   ;
//				IF IsNull( li_cnt ) OR li_cnt = 0 THEN
//					ls_rec_status = "New"
//				END IF
//			end if //modified
//			//End Code Change---10.26.2007
//		END IF
//	//jad 05/30/01 added to make any screen facility specific
//	ELSEIF li_facility_specific = 1 THEN //attest quest or group cov	
//		if This.Describe("facility_id.ColType") <> "!" then  //Start Code Change ---- 01.25.07.2007 #V7 maha
//			This.SetItem( i, "facility_id", ii_parent_facility_id )	
//		end if	
//	END IF
//	IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN
//		This.ScrollToRow( i )
//		This.SetRow( i )
//
//		//move expiration date to verif info table if there is one
//		IF Len(ls_exp_field) > 0 THEN
//			IF ls_exp_field = "certification_expires" THEN	
//				ldt_exp_date = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())
//				ldt_exp_date_original = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-12-30"),Now())				
//			ELSEIF ls_exp_field = "cert_expiration_year" THEN
//				li_month = this.GetItemNumber( i, "cert_expiration_month" )
//				if isnull(li_month) then
//					ldt_exp_date = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())
//					ldt_exp_date_original = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-12-30"),Now())				
//				else
//					ldt_exp_date = DateTime(Date(String( This.GetItemNumber( i, ls_exp_field ) ) + "-" + String(li_month) + "-28"),Now())
//					ldt_exp_date_original = DateTime(Date(String( This.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-" + String(li_month) + "-28"),Now())
//				end if
//			ELSE
//				if This.Describe(ls_exp_field + ".ColType") <> "!" then
//					ldt_exp_date = This.GetItemDateTime( i, ls_exp_field )
//					ldt_exp_date_original = This.GetItemDateTime( i, ls_exp_field, Primary!, True )
//				else
//					of_error_message( ls_exp_field, i,"Unable to update data","The " + upper(ls_exp_field) + " field is required by your system settings.~r~rYou will not be able to save data on this screen~runtil the field is made visible in the Screen Painter for the view you are using.")
//					return -1
//				end if
//			END IF
//		ELSE
//			ldt_exp_date = ldt_null_date
//			SetNull( ldt_exp_date_original )
//		END IF
//	
//		//get reference 1 data 		
//		if This.Describe(ls_ref_1 + ".ColType") = "!"  or ls_ref_1 = "" then //trap for invisible field maha 012104 
//			messagebox("Problem getting reference 1 value for verification","Required Field " + ls_ref_1 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
//			return 1
//		end if
//		li_retval = This.SetColumn( ls_ref_1 )
//		IF li_retval = 1 THEN
//			IF IsNull( GetText() ) OR GetText() = "" THEN
//				SetRedraw( True )
//				of_error_message(ls_ref_1,i,"Required", "The data field " + ls_ref_1 + " is required.")
//				Return -1
//			END IF
//			li_retval = This.GetChild(ls_ref_1, dwchild)
//			IF li_retval = -1 THEN
//				ls_reference =  This.GetText()				
//			ELSE
//				This.SetColumn( ls_ref_1 )
//				li_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, 100000 )
//				IF li_found < 1 THEN // Add by Evan 05.04.2010 --- trap for row number
//					ls_reference = This.GetText()
//				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" THEN
//					ls_reference = dwchild.GetItemString( li_found, "code" )
//					IF ii_screen_id = 4 THEN					
//						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
//							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
//							return -1
//						else
//							ll_address_code = This.GetItemNumber( i, "verifying_agency" )
//						end if
//					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
//						//do nothing, got the address code further up
//					ELSE
//						if ls_type1 = "C" then //maha 050802 
//							ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
//						elseif ls_type1 = "N" then //maha 050802
//							ll_address_code = This.GetItemNumber( i, ls_ref_1 )
//						end if
//					END IF
//				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
//					if This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
//						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )  //Start Code Change ----03.04.2009 #V92 maha -  changed this to aloways use the entity name originalf the of containg the code as well, 
//					else
//						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
//					end if
//					if ls_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
//						ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
//					elseif ls_type1 = "N" then //maha 102501
//						ll_address_code = This.GetItemNumber( i, ls_ref_1 )
//					end if
//				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
//					ls_reference = dwchild.GetItemString( li_found, "description" )
//					//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
//					IF ii_screen_id = 4 THEN					
//						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
//							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
//							return -1
//						else
//							ll_address_code = This.GetItemNumber( i, "verifying_agency" )
//						end if
//					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
//						//do nothing, got the address code further up
//					ELSE
//						if ls_type1 = "C" then //maha 050802 
//							ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
//						elseif ls_type1 = "N" then //maha 050802
//							ll_address_code = This.GetItemNumber( i, ls_ref_1 )
//						end if
//					END IF
//					//End Code Change---10.10.2007
//				ELSE
//					ls_reference = This.GetText()			
//				END IF
//			END IF
//		ELSE
//			ls_reference = ""
//		END IF
//
//	   If NOT Isnull(ls_ref_2) THEN
//			//get reference 2 data
//			if This.Describe(ls_ref_2 + ".ColType") = "!" or ls_ref_2 = "" then //trap for invisible field maha 012104 
//				messagebox("Problem getting reference 2 value for verification","Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
//				return 1
//			end if
//			li_retval = This.SetColumn( ls_ref_2 )
//			IF li_retval = 1 THEN
//				IF IsNull( GetText() ) OR GetText() = "" THEN
//					SetRedraw( True )
//					of_error_message(ls_ref_2,i,"Required", "The data field " + ls_ref_2 + " is required.")
//					Return -1
//				END IF		
//				li_retval = This.GetChild(ls_ref_2, dwchild)
//				IF li_retval = -1 THEN
//					ls_reference = ls_reference + " - " + This.GetText()				
//				ELSE
//					This.SetColumn( ls_ref_2 )
//					li_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, 100000 )
//					if li_found > 0 then //trap added maha 021704
//						IF This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" THEN
//							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
//						ELSEIF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" THEN
//							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )					
//						ELSEIF This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
//							if This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
//								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
//							else
//								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
//							end if
//						ELSE
//							ls_reference = ls_reference + " - " + This.GetText()
//						END IF
//					else
//						ls_reference = ls_reference + " - " + ""
//					end if
//				END IF
//			ELSE
//				ls_reference = ls_reference + " - " + ""
//			END IF
//			
//			ls_reference = mid(ls_reference,1,100) //maha 022704 4.1.1
//		END IF
////@@@@@
//
//		//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function
//		if this.Describe("active_status.ColType") <> "!" then
//			li_status = this.getitemnumber(i,"active_status") //Start Code Change ----04.19.2010 V10 maha - changed from li_data_cr
//		end if
//		//End Code Change---08.01.2008
//		//Start Code Change ---- 10.26.2006 #1 maha
//		IF ls_rec_status = "Modified" THEN
//			parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_update_reference( ls_reference,  ll_rec_id, ll_address_code,  ldt_exp_date , li_screen_id,li_status)  //Start Code Change ----04.22.2008 #V8 maha - added screen id argument ; 08.01.2008 added li_status argument
//			inv_data_entry.of_app_audit_update_ref( il_prac_id , ll_rec_id , mid(ls_screen_name,1,5) + "-" + ls_reference )
//
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 2006-10-11 By: Rodger Wu (Inova)
//			//$<reason> 
//			IF ( Isnull( ldt_exp_date_original ) and Not Isnull( ldt_exp_date ) ) or &
//				( Isnull( ldt_exp_date ) and Not Isnull( ldt_exp_date_original ) ) or &
//				( DaysAfter( date( ldt_exp_date_original ), date( ldt_exp_date ))) <> 0 THEN
//				ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
//			END IF
//			//---------------------------- APPEON END ----------------------------
//		ELSE  //new
//			for t = 1 to li_temp_cnt //check to see if completion is desired
//				if li_complete[t] = 1 then 
//					openwithparm(w_app_audit_complete_mes,  ls_mess) //asks user to complete and gets response code 
//					ls_mess = message.stringparm
//					if mid(ls_mess,1,1) = "N" then 
//						li_complete[t] = 0
//						ll_verif_response = 0
//					else //yes
//						ll_verif_response = long(mid(ls_mess,3))
//					end if	
//				else //Start Code Change ---- 05.09.2007 #V7 maha trap so verif does not get completed
//					li_complete[t] = 0
//					ll_verif_response = 0
//				end if
//				if li_auto_gen[t] = 1 then  //Start Code Change ---- 05.09.2007 #V7 maha only create if set to auto gen
//					inv_data_entry.of_app_audit_item_create( li_app_audit_facil ,il_prac_id ,ll_templ_id[t] ,ll_appt_stat_recid , ll_rec_id , "DE" , li_complete[t] , mid(ls_screen_name,1,5) + "-" + ls_reference )
//				end if
//			next
//			IF Upper( gs_cust_type ) = 'I' THEN ll_verif_response = 326 //if intelliapp, always set to complete the verification
//			IF parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_add_record( il_prac_id, ll_rec_id, li_screen_id, ls_reference,  ldt_exp_date, ls_screen_name, ll_address_code, "A",li_month,li_year,ll_verif_response, li_status) = -1 THEN  //Start Code Change ----.2008 #V85 maha - added li_status argument
//					Return -1
//					messagebox("Error","Error adding verification")
//				end if
//			END IF
//			parent_window.ib_app_audit_retrieved = false //Start Code Change ---- 10.30.2006 #1 maha
//		//End Code Change---10.26.2006
////@@@@@
//	END IF
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 10.12.2006 By: Jack (Inova)
//	//$<reason> Queue Images for Scanning from Data Entry.
//	long ll_row,ll_seq_no,ll_image_type_id,ll_default_pages,ll_de_queue
//	if ls_rec_status = "New" then
//		ll_de_queue = long(gnv_data.of_getitem('image_type','de_queue','link_to_screen = ' + string(li_screen_id)))
//		//ll_de_queue = 0 //maha changed because it was not working properly
//		if ll_de_queue = 1 then
//			ll_image_type_id = long(gnv_data.of_getitem('image_type','image_type_id','link_to_screen = ' + string(li_screen_id)))
//			ll_default_pages = long(gnv_data.of_getitem('image_type','default_pages','link_to_screen = ' + string(li_screen_id)))
//
//			ll_row = ids_image_data.insertrow(0)
//			
//			SELECT Max( seq_no )  
//			INTO :ll_seq_no  
//			FROM pd_images  
//			WHERE pd_images.rec_id = :ll_rec_id ;
//			
//			IF IsNull( ll_seq_no ) THEN
//				ll_seq_no = 0
//			END IF
//			ll_seq_no++
//			ids_image_data.SetItem( ll_row, "image_type_id", ll_image_type_id )
//			ids_image_data.SetItem( ll_row, "prac_id", il_prac_id )
//			ids_image_data.SetItem( ll_row, "seq_no", ll_seq_no )
//			ids_image_data.SetItem( ll_row, "rec_id", ll_rec_id  )
//			ids_image_data.SetItem( ll_row, "facility_id", ii_parent_facility_id  )	
//			ids_image_data.SetItem( ll_row, "screen_id", li_screen_id )	
//			ids_image_data.SetItem( ll_row, "reference_name", ls_reference )
//			ids_image_data.SetItem( ll_row, "active_status", 1 )	
//			ids_image_data.SetItem( ll_row, "num_pages", ll_default_pages )
//			ids_image_data.SetItem( ll_row, "tif_start_page", 1 )
//			ids_image_data.SetItem( ll_row, "de_queue", 0 )
//		end if
//	end if
//	//---------------------------- APPEON END ----------------------------
//END FOR
//
//This.ScrollToRow( li_data_cr )
//This.SetRow( li_data_cr )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 06/03/2008 By: Ken.Guo
////$<reason> Fix issue. After save address data, address link data disappear.
//if li_data_cr > 0 then
//	il_rec_id = This.GetItemNumber( li_data_cr, "rec_id" )
//end if
////---------------------------- APPEON END ----------------------------
//
//dw_detail.BringToTop = True
//of_get_record_verif( li_data_cr )
//
////IF is_screen_name = "Hospital Affiliation" or is_screen_name = "Address"  then //\/maha 082101 
////if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" or is_screen_name = "Board/Specialty"then
//IF ii_screen_id = 10 or ii_screen_id = 2 or ii_screen_id = 19  then
//	dw_link_list.bringtotop = True
//end if
//
//This.SetRedraw( True )
//
//dw_detail.SetColumn( is_first_column_detail_1 )
//dw_detail.SetFocus()
//
//inv_data_entry.of_field_audit( This )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-26
////$<modify> 2006-04-11 By: owen chen
////$<reason> Performance tuning modification
////$<modification> 1)Modify the script in the pfc_Save from PT-28.
////$<modification> 2)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//gnv_appeondb.of_startqueue( )
//IF ids_parent_facilities.rowcount( ) > 0 THEN
//	dw_link_list.Update()
//	dw_link_list.Retrieve( il_rec_id )
//END IF
//ids_image_data.update() //Queue Images for Scanning from Data Entry - Jack 10.12.2006 
//gnv_appeondb.of_commitqueue( )
//
//DESTROY ids_parent_facilities
////---------------------------- APPEON END ----------------------------
//
////keep qualified df ids - dataflow: alfee 12.24.2009
//inv_dataflow.of_set_data_flow(this, li_table_id)
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2006-10-11 By: Rodger Wu (Inova)
////$<reason> Automatically poping up Verification Update window once
////$<reason> value in exp_field changed.
//String ls_sql_where, ls_rec_id_str, ls_sql_original
//n_ds lds_verify
//gs_verif_update lstr_verif
//
//li_cnt = UpperBound( w_mdi.ii_security_action_id )
//FOR i = 1 TO li_cnt
//	IF w_mdi.ii_security_action_id[ i ] = 160 THEN
//		IF w_mdi.ii_security_action_value[ i ] = 0 THEN
//			Return 1; //No rights	
//		END IF
//	END IF		
//NEXT
//
//li_cnt = UpperBound( ll_rec_id_changed )
//IF li_cnt > 0 THEN
//	FOR i = 1 TO li_cnt
//		ls_rec_id_str += string( ll_rec_id_changed[i] ) + ", "
//	NEXt
//	lds_verify = Create n_ds
//	lds_verify.DataObject = "d_verification_facility_de_update_maha"
//	lds_verify.SetTransObject( SQLCA )
//	lstr_verif.sql_syntax = ""//ls_sql_original
//	lstr_verif.al_prac_id = il_prac_id
//	lstr_verif.al_screen_id = li_screen_id
//	lstr_verif.al_rec_id = ll_rec_id_changed
//	
//	OpenwithParm( w_verification_de_update, lstr_verif )
//END IF
////---------------------------- APPEON END ----------------------------
//
RETURN 1
//
end event

event pfc_preinsertrow;//\/maha 050701 to trap save errors when entering multiple records

Integer li_retval

// mskinner 17 dec 2005 -- begin
// do not allow for the addition os rows in the PERSIONL DATA screen

STRING LS_SCREEN_NAME
LS_SCREEN_NAME = UPPER(dw_select_section.object.screen_name[dw_select_section.getRow()])
if upper(TRIM(LS_SCREEN_NAME)) = 'PERSONAL DATA' THEN 
	RETURN Failure
END IF 

// mskinner 17 dec 2005 -- end


//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" then
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-28
//$<comment> 2006-04-10 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Move the script to PT-26. It is integrated into Appeon Queue labels
//$<modification> to reduce client-server interactions.
/*
li_retval = Parent_window.Event pfc_Save()
	//debugbreak()
	IF li_retval < 0 THEN
		This.PostEvent( "pfc_cst_after_error" )
		Return 1
	END IF
*/

//---------------------------- APPEON END ----------------------------

		
//end if
	
return continue_action

//\maha
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dw_app_data_compare.bin 
2000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000b076cdf001d18afd00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000b076cdf001d18afdb076cdf001d18afd000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc0000000300020005000000030000485900000003000043e7000000030000006000000002000000010000001e0000000945676d493174696400000000000000031ffffffe0000000b0000ffff000000020000bb8c000000020000bb8c000000030012bbdc000000030012bbdc0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500004859000043e70000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000001fffff00000000ee000100bc2000001000bc20100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000b076cdf001d18afd00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000b076cdf001d18afdb076cdf001d18afd000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000300020000038400000384000000000000010000000000000000000000000001010000000000000000000000000000010003000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001000000000200000300000000000300000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dw_app_data_compare.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
