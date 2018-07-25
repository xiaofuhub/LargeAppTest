$PBExportHeader$pcf_cst_prac_data_view.sru
forward
global type pcf_cst_prac_data_view from userobject
end type
type dw_link_list from u_dw within pcf_cst_prac_data_view
end type
type dw_detail from u_dw within pcf_cst_prac_data_view
end type
type dw_browse from u_dw within pcf_cst_prac_data_view
end type
type dw_select_section from u_dw within pcf_cst_prac_data_view
end type
end forward

global type pcf_cst_prac_data_view from userobject
integer width = 1097
integer height = 2460
boolean border = true
long backcolor = 33551856
string text = "none"
borderstyle borderstyle = StyleBox!
boolean resizable = true
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_link_list dw_link_list
dw_detail dw_detail
dw_browse dw_browse
dw_select_section dw_select_section
end type
global pcf_cst_prac_data_view pcf_cst_prac_data_view

type variables
boolean ib_link = false
long il_pracs[]
long il_batch
long il_pracid
long il_screen
long il_dvid = 1
long il_rec_id
long il_wc_id
long il_facility
long il_entity
long il_recid
string is_save_type = 'N'
string is_prac_names[]
string is_url
string is_type
string is_lookup_search_column_field = "None" 
string is_lookup_search_column_table = "None"
string is_sql_syntax
string is_first_column_detail_1
pfc_cst_nv_data_entry_functions inv_data_fun
pfc_n_cst_ai_action_items  inv_action_items
end variables

forward prototypes
public function integer of_initiate (long al_prac, integer al_dvid, integer al_facility)
public subroutine of_resize (boolean ab_link)
end prototypes

public function integer of_initiate (long al_prac, integer al_dvid, integer al_facility);
 string ls_site
 
 inv_data_fun = create pfc_cst_nv_data_entry_functions
 inv_data_fun.of_setup_cache()
inv_data_fun.of_refresh_cache()


il_pracid = al_prac
il_dvid = of_get_default_view(gs_user_id, al_facility)
il_screen = 1
il_facility = al_facility


dw_detail.of_settransobject( sqlca)

dw_select_section.retrieve(il_dvid)

return 1
end function

public subroutine of_resize (boolean ab_link);long ll_w
long ll_h
long ll_split
long ll_lsplit

ll_h = this.height
ll_w = this.width
ll_split = ll_h / 4 - 10

if ab_link then
	ll_lsplit = ll_split * 2 / 7
end if

dw_select_section.width = ll_w
dw_browse.width = ll_w
dw_detail.width = ll_w

if ab_link then
	dw_link_list.width = ll_w
end if 

if ab_link then
	dw_select_section.height = ll_lsplit * 3
	dw_browse.height =  ll_lsplit * 3
	dw_link_list.height = ll_lsplit
	dw_detail.height = ll_split * 2
	dw_browse.y = ll_lsplit * 3 + 4
	dw_link_list.y =  dw_browse.y + dw_browse.height + 4
	dw_detail.y = dw_link_list.y + dw_link_list.height + 4
	dw_link_list.visible = true
else
	dw_select_section.height = ll_split
	dw_browse.height = ll_split
	dw_detail.height = ll_split * 2
	dw_browse.y = ll_split + 4
	dw_detail.y = dw_browse.y + dw_browse.height + 4
	dw_link_list.visible = false
end if


end subroutine

on pcf_cst_prac_data_view.create
this.dw_link_list=create dw_link_list
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.dw_select_section=create dw_select_section
this.Control[]={this.dw_link_list,&
this.dw_detail,&
this.dw_browse,&
this.dw_select_section}
end on

on pcf_cst_prac_data_view.destroy
destroy(this.dw_link_list)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.dw_select_section)
end on

event constructor;//post of_initiate( 1, 1, 2)
end event

type dw_link_list from u_dw within pcf_cst_prac_data_view
integer y = 1032
integer width = 1102
integer height = 144
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hosp_facil_link_view"
boolean vscrollbar = false
end type

event constructor;call super::constructor;This.of_SetTransObject( sqlca )
end event

event retrieveend;call super::retrieveend;//of_filter_links("One") //Start Code Change ----10.21.2010 #V10 maha - filter to one facility record
end event

type dw_detail from u_dw within pcf_cst_prac_data_view
integer y = 1176
integer width = 1102
integer height = 1284
integer taborder = 30
boolean bringtotop = true
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked; //Start Code Change ----03.01.2017 #V153 maha
string ls_type
string ls_value
string ls_field
string ls_lookup
string ls_describe 
boolean lb_lu = false
integer li_col

//li_col = this.getclickedcolumn()
ls_field = this.getcolumnname( )
//messagebox("",ls_field)
ls_type = This.Describe( ls_field + ".ColType") 
//messagebox("",ls_type)
ls_lookup = This.Describe( ls_field + ".dddw.name")
//messagebox("",ls_lookup)

if ls_lookup <> "?" then
	lb_lu = true
end if


if row < 1 then return //(Appeon)Stephen 09.18.2016 - V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row

if lb_lu then
	ls_describe = "Evaluate('LookUpDisplay(" + ls_field + ")', " + string(row) + ")"  
	ls_value = this.Describe(ls_describe) 
else
	choose case upper(mid(ls_type,1,3))
		//case "last_name", "first_name"
		case "VAR","CHA"
			ls_value = this.getitemstring(row,ls_field)
		case "DAT"
			ls_value = string(date(this.getitemdatetime(row,ls_field)))   //Start Code Change ----03.08.2017 #V153 maha - date only
		case else
			ls_value = string(this.getitemnumber(row,ls_field))
	end choose
end if

//messagebox("",ls_value)
::clipboard(ls_value)

//Start Code Change ----03.06.2017 #V153 maha
IF IsValid(w_preview_app) THEN 
	w_preview_app.uo_1.of_create_text("LABEL-" + ls_value, 2, 0 )
elseif IsValid(w_preview_app_popup)  then     //Start Code Change ----07.18.2016 #V152 maha
	w_preview_app_popup.uo_1.of_create_text("LABEL-" + ls_value, 2, 0)
end if
//End Code Change ----03.06.2017
end event

type dw_browse from u_dw within pcf_cst_prac_data_view
integer y = 528
integer width = 1102
integer height = 504
integer taborder = 20
boolean bringtotop = true
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_rec

dw_detail.scrolltorow(currentrow)

 //Start Code Change ----03.06.2017 #V153 maha
choose case il_screen
	case 2, 10,19
		ll_rec = this.getitemnumber(currentrow, "rec_id" )
		//messagebox("rec id",string(ll_rec) + " - " + string(il_facility))
		dw_link_list.retrieve(ll_rec, il_facility)
end choose		

end event

event clicked;call super::clicked;this.setrow(row)

end event

type dw_select_section from u_dw within pcf_cst_prac_data_view
event pfc_after_select ( )
event ue_goto_status ( )
event pfc_cst_after_error ( )
integer width = 1102
integer height = 532
integer taborder = 10
boolean bringtotop = true
string title = "Select Data Screen"
string dataobject = "d_data_view_screens_list"
boolean hscrollbar = true
end type

event pfc_after_select();String	ls_PicPath,ls_PicName,ls_Postfix
long li_find, rc  //maha 07.15.2015

//IF dw_browse.RowCount() > 1 THEN
////	dw_browse.SelectRow( 1, True )   //Start Code Change ----01.20.2016 #V15 maha - removed
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
if dw_browse.rowcount() > 0 then //add by stephen 03.18.2013 -Invalid DataWindow row/column specified
	//pcf_cst_prac_data_view.SetRedraw (false )
	Choose case il_screen
		case 2 
			il_recid = dw_browse.getitemnumber(1,"rec_id")
			dw_link_list.dataobject = "d_addr_link_view"
			dw_link_list.settransobject(sqlca)
			dw_link_list.retrieve(il_recid, il_facility)
			ib_link = true
		case 10 
			il_recid = dw_browse.getitemnumber(1,"rec_id")
			dw_link_list.dataobject = "d_hosp_facil_link_view"
			dw_link_list.settransobject(sqlca)
			dw_link_list.retrieve(il_recid, il_facility)
			ib_link = true
		case 19 
			il_recid = dw_browse.getitemnumber(1,"rec_id")
			dw_link_list.dataobject = "d_spec_facil_link_view"
			dw_link_list.settransobject(sqlca)
			dw_link_list.retrieve(il_recid, il_facility)
			ib_link = true
		case else
			ib_link = false
	end choose
	
	of_resize( ib_link)
	//pcf_cst_prac_data_view.SetRedraw (True )
end if


// //Start Code Change ----07.15.2015 #V15 maha
//Choose case il_screen
//				
//	case 32,65,70,71,26  //Start Code Change ----05.09.2014 #V14.2 maha - added for facility specific screens
//		 //Start Code Change ----07.16.2015 #V15 maha
//		if  ii_screen_id = 65 then
//			dw_link_list.dataobject = "d_facility_linked_data_facilities_attest"
//		else
//			dw_link_list.dataobject = "d_facility_linked_data_facilities"
//		end if
//		//End Code Change ----07.16.2015
//		dw_link_list.settransobject(sqlca)
//		rc = dw_link_list.retrieve(il_prac_id, gs_user_id) //add gs_user_id by Appeon long.zhang 04.02.2015 (V14.2 Bug # 4471 - DataWindow error when selecting facility specific data screens )
//
//		if rc > 0 then
//			//Start Code Change ----07.16.2015 #V15 maha
//			if  ii_screen_id = 65 then
//				li_find = dw_link_list.find("pd_affil_stat_rec_id  = " + string(il_affil_recid) , 1, rc)
//			else
//				li_find = dw_link_list.find("facility_id = " + string( ii_parent_facility_id), 1, rc)
//			end if
//			//End Code Change ----07.16.2015
//			if li_find > 0 then
////				dw_link_list.selectrow(li_find,true)  //Start Code Change ----03.16.2016 #V15 maha - removed
//				dw_link_list.scrolltorow(li_find)
//			end if
//		end if
//End choose
////End Code Change  ----07.15.2015
//

//\ maha
//\/maha 072301 prac picture
//if is_screen_name = "Basic Information" then
// if ii_screen_id = 1 then

//	if IsValid(m_pfe_cst_data_entry) then
//		if w_mdi.of_security_access( 40 ) < 2 or w_mdi.of_security_access( 50 ) < 2 then
////			m_pfe_cst_data_entry.m_file.m_importphoto.enabled = false
////			m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = false  //maha072209
//			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_importphoto,'enabled', false)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_clearphoto,'enabled', false)
//		else
////			m_pfe_cst_data_entry.m_file.m_importphoto.enabled = true
////			m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = true //maha072209
//			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_importphoto,'enabled', true)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_clearphoto,'enabled', true)
//		end if
//	end if
//	//------------------- APPEON END ---------------------
	
//	SELECT image_type INTO :ls_Postfix from pd_photo WHERE pd_photo.prac_id = :gl_prac_id ;
//	
//	if IsNull(ls_Postfix) or Trim(ls_Postfix) = "" then
//		Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
//		//Parent_Window.tab_1.tabpage_detail.p_face.PictureName = "nophoto.bmp"
//	else
//		ls_PicPath = TRIM(gnv_data.of_getitem("ids","picture_path",false))
//		if Right(ls_PicPath,1) <> "\" then ls_PicPath += "\"
//		
//		ls_PicName = ls_PicPath + String(gl_prac_id) + "." + ls_Postfix
//		
//		of_Download_Photo(gl_prac_id,ls_PicPath)
//		
//		if FileExists(ls_PicName) then
//			Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
//			//Parent_Window.tab_1.tabpage_detail.p_face.Visible = true
//			Parent_Window.tab_1.tabpage_detail.p_face.BringToTop = true
//			Parent_Window.tab_1.tabpage_detail.p_face.PictureName = ""
//			Parent_Window.tab_1.tabpage_detail.p_face.PictureName = ls_PicPath + String(gl_prac_id) + "." + ls_Postfix
//		else
//			Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
//		end if
//	end if
//---------------------------- APPEON END ----------------------------
	
	
////Start Code Change ----04.23.2008 #V8 maha	- modification to set ssn /npi from search
//	if mid(gs_ssnnpi,1,1 ) = "S" then
//		if dw_detail.Describe("ssn.ColType") <> "!" then
//			if isnull(dw_detail.getitemstring(1,"ssn")) then dw_detail.setitem(1,"ssn", mid(gs_ssnnpi,3)) //Start Code Change ----11.17.2009 #V92 maha - changed to not overwrite
//		end if
//		gs_ssnnpi = ""
//	elseif mid(gs_ssnnpi,1,1 ) = "N" then
//		if dw_detail.Describe("npi_number.ColType") <> "!" then
//			if isnull(dw_detail.getitemstring(1,"npi_number")) then dw_detail.setitem(1,"npi_number", mid(gs_ssnnpi,3))  //Start Code Change ----11.17.2009 #V92 maha - changed to not overwrite
//		end if
//		gs_ssnnpi = ""
//	end if
////End Code Change---04.23.2008
//else
//	if IsValid(m_pfe_cst_data_entry) then 
////		m_pfe_cst_data_entry.m_file.m_importphoto.Enabled = false		//Added by Scofield on 2008-09-23
////		m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = false	//maha 072209
//		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_importphoto,'enabled', false)
//		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_clearphoto,'enabled', false)
//	end if
//	parent_window.tab_1.tabpage_detail.p_face.visible = false
//end if
////End Code Change---04.23.2008

//Start Code Change ----05.16.2016 #V15 maha
dw_browse.Modify ("DataWindow.Detail.color='536870912~tif( getrow() = currentrow(), rgb(168, 205, 241), rgb(255, 255, 255) )'")
//messagebox("",err)
//End Code Change ----05.16.2016

//Start Code Change ---- 06.15.2006 #545 maha removed existing code
//of_detail_scrollbar(ii_screen_id)
//End Code Change---06.15.2006

//of_links_security(ii_screen_id)   //Start Code Change ----05.26.2009 #V92 maha 
//
//of_refresh_page_menu( ) //Start Code Change ----03.27.2012 #V12 maha
//
//if this is a custom screen then put a scroll bar on it
//IF ii_screen_id > 100 THEN
	dw_detail.vscrollbar = True
//END IF

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
this.of_settransobject(sqlca)

end event

event retrieveend;call super::retrieveend;//used to change the icon for screens where the practitioner has data. 
//if  not ib_screen_painter then
//	of_screen_color()
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;//----------------------------- RP added 1.12.2016------------------------
this.setRedraw(TRUE)

IF currentrow = 0 THEN
	Return
END IF

//if ib_report = true then return

Long ll_height
Long ll_data_view_id
Long ll_detail_2_screen_id
String ls_screen_name
string err
Integer li_retval
Integer li_last_fld_y


//ii_address_lnk_cnt=0

//IF ib_refresh_screen_list = True THEN
// RP	This.SelectRow( 0, False )
// RP	This.SelectRow( il_last_row, True )
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
//
ls_screen_name = This.GetItemString( currentrow, "screen_name" )
//messagebox('',ls_screen_name)

//Start Code Change ----01.15.2013 #V12 maha
//if this.getitemnumber(currentrow, "batch_add_field" ) > 0 then ib_add = false

//debugbreak()

//SetRedraw(False)
//Start Code Change ---08.19.2008 #V85 maha - moved the detail 2 screen creation before the detail screen so that setting defaults will work
il_dvid = This.GetItemNumber( currentrow, "data_view_id" )
il_screen = This.GetItemNumber( currentrow, "screen_id" )

////Start Code Change ----03.16.2016 #V15 maha - modified to get facility specific field for facility links dw
//if this.getitemnumber(currentrow, "facility_specific" ) > 0 then 
//	ib_facil_links = true
//else
//	ib_facil_links = false
//end if

////set the addr,specialty and hosp
//choose case ii_screen_id
//	case 2,10,19
//		ib_facil_links = true
//end choose
////End Code Change ----03.16.2016

//IF This.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
//	ll_detail_2_screen_id = This.GetItemNumber( currentrow, "table_id_2" ) 
//	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ll_detail_2_screen_id, tab_view.tabpage_image.dw_detail_2, tab_view.tabpage_image.dw_detail_2, ib_screen_painter, ii_parent_facility_id, true )	
//	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
//	of_modify_dw_access(il_prac_id ,  tab_view.tabpage_image.dw_detail_2) //Added by Appeon long.zhang 11.17.2014
//	tab_view.tabpage_image.Visible = True
//else
//	tab_view.tabpage_image.Visible = False
//END IF

////Start Code Change ----03.10.2014 #V14.2 maha
//if ii_screen_id = 2 then
//	tab_view.tabpage_linked_data.Visible = true
//else
//	tab_view.tabpage_linked_data.Visible = False
//	//tab_view.tabpage_linked_data.of_hide_links()
//end if
////End Code Change ----03.10.2014


is_sql_syntax = inv_data_fun.of_create_dynamic_dw_display( il_pracid, il_dvid, il_screen, dw_detail, dw_browse, false, il_facility, false )
is_first_column_detail_1 = inv_data_fun.of_get_first_column()
//of_modify_dw_access(il_pracid , dw_detail) //Added by Appeon long.zhang 11.17.2014

//---------Begin Added by (Appeon)Stephen 07.16.2015 for Bug id 4601 - Allegheny Webview Data Audit Case# 55838, 55847--------
if il_screen = 65 then	 
	if gl_prac_de_appt_id > 0 then
		dw_browse.setfilter("appt_stat_id = " + string(gl_prac_de_appt_id ))
		dw_detail.setfilter("appt_stat_id = " + string(gl_prac_de_appt_id ))
	else
		dw_browse.setfilter("active_status in ( 1,4)")
		dw_detail.setfilter("active_status in ( 1,4)")
	end if
	dw_browse.filter()
	dw_detail.filter()
	dw_browse.modify("active_status_1.tabsequence='0'")
	dw_browse.modify("appt_stat_id_1.tabsequence='0'")
end if
dw_browse.setredraw(true)
dw_detail.setredraw(true)
dw_browse.setfilter("")
dw_detail.setfilter("")
//---------End Added ------------------------------------------------------

//------------Begin Added by alfee 09.10.2010 -------------------------------------
//Add a button to access image(s) to the screen - SK Practitioner Folder
//if gb_sk_ver and not of_get_ib_screen_painter () then 
//if not of_get_ib_screen_painter () then 	//alfee 11.22.2010
//	long ll_cnt
//	select count(*) into :ll_cnt from pd_images, image_type 
//	 where pd_images.image_type_id = image_type.image_type_id 
//	   and pd_images.prac_id = :il_prac_id and image_type.link_to_screen = :ii_screen_id ;
////Start Code Change ----01.25.2016 #V15 maha - changed font and color
//	if ll_cnt > 0 then 
//		if of_get_app_setting("set_img","I") = 1 and w_mdi.of_security_access(1000) > 0 then //Start Code Change ----05.11.2011 #V11 maha - security trap
//			dw_detail.Modify ("DataWindow.Header.Height= '110'" )
//			dw_detail.Modify("create button(band=header text='Access Image(s)' filename=''action='0' border='1' color='8388608' x='10' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = imgbutton)")
//		end if
//	end if		
//end if	
//------------End Added ---------------------------------------------------------------
////Start Code Change ----12.02.2010 #V10 maha - work gap calculation  //Start Code Change ----09.27.2012 #V12 maha - added education and training
//choose case ii_screen_id
//	case 12, 6, 7, 10, 55 //work gap button
//		dw_detail.Modify ("DataWindow.Header.Height= '110'" )
//		dw_detail.Modify("create button(band=header text='Calculate Work Gap' filename=''action='0' border='1' color='8388608' x='1096' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = gapbutton)")
//	case 13		// references //Start Code Change ----02.08.2013 #V12 maha - moved from dynamic dw creation
//		IF of_get_app_setting("set_5","I") = 0 THEN//(Appeon)Toney 11.07.2013 - V141 ISG-CLX,Fix BugT110603, Create Button by system parameter
//			dw_detail.Modify ("DataWindow.Header.Height= '110'" )
//			dw_detail.Modify("create button(band=header text='Select Peer' filename=''action='0' border='1' color='8388608' x='1100' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")
//		END IF
//	case 2 //address screen
//		dw_detail.Modify ("DataWindow.Header.Height= '110'" )
//		dw_detail.Modify("create button(band=header text='Find Addresses' filename=''action='0' border='1' color='8388608' x='1100' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
//		//Start Code Change ----05.07.2013 #V12 maha		
//		dw_detail.Modify("create button(band=header text='Add/View Pending Changes' filename=''action='0' border='1' color='8388608' x='1750' y='16' height='85' width='800' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256'  visible='1~tif( isNull(rec_id),0,1)' name = pendingbutton)")//uncommented by long.zhang v14.1 group location effective date ;added visibile property by long.zhang 11.13.2013 
//		//Start Code Change ----11.19.2013 #V14 maha
//		//Start Code Change ----10.06.2014 #V14.2 maha - removed, shown on Linked data tab
////		if of_get_app_setting("set_iapps","I") = 1 and of_get_app_setting("set_74","I") = 1 then
////			dw_detail.Modify("create button(band=header text='Linked Ids' filename=''action='0' border='1' color='128' x='660' y='16' height='85' width='425' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = id_link)")
////		End if
//		//End Code Change ----10.06.2014
//end choose	
////End Code Change ----12.02.2010


//Start Code Change ----01.05.2015 #V14.2 maha - view entity
choose case il_screen
	case 5, 6, 7, 10, 15, 19, 72, 18      ,8, 3, 11, 14,12, 9   //view entity button  //maha 11.18.2016 - added additional screens
		dw_detail.Modify ("DataWindow.Header.Height= '110'" )
		dw_detail.Modify("create button(band=header text='View Entity' filename=''action='0' border='1' color='8388608' x='1750' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = viewentity)") 
end choose	
//End Code Change ----01.05.2015
//End Code Change ----01.25.2016

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

// RP This.SelectRow(0, False)
// RP This.SelectRow( currentrow, True)

//IF This.GetItemString( currentrow, "multi_record" ) = "Y" THEN
//	tab_view.tabpage_browse.Enabled = True
//ELSE
//	tab_view.tabpage_browse.Enabled = False
//END IF

//ll_height = Long( dw_detail.Describe("DataWindow.Detail.Height") )


//Start Code Change ---- 06.15.2006 #546 maha
//of_detail_scrollbar(ii_screen_id)
//End Code Change---06.15.2006


//
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
//	dw_detail.PostEvent("pfc_after_select")	
//END IF


//dw_link_list.visible = false
//
//of_add_delete_enable()
//
//dw_browse.SelectRow( 0, False)   //Start Code Change ----01.20.2016 #V15 maha - removed

//---------Begin Modified by (Appeon)Harry 06.29.2013 for V141 ISG-CLX--------
//Start Code Change ----10.07.2009 #V10 maha - for Lehigh
//if of_get_app_setting("set_58","I") = 1 then
//if of_get_app_setting("set_91","I") = 1 then
////---------End Modfiied ------------------------------------------------------
//	parent_window.title = parent_window.is_prac_title + " - " + ls_screen_name 
//	//parent_window.title = parent_window.is_full_name  + " - " + String( parent_window.il_prac_id ) + "  (" + parent_window.is_facility_name + ")" + " - " + ls_screen_name 
//end if
//End Code Change---10.07.2009

This.PostEvent("pfc_after_select")

//il_last_row = currentrow
end event

event rowfocuschanging;call super::rowfocuschanging;//Integer li_retval
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-19
////$<add> 03.03.2006 By: Cao YongWang
////$<reason> Performance tuning. 
////$<modification> Write script to make sure that when pfc_cst_u_data_entry
////$<modification> is just opened, RowFocusChanging is not executed immediately.
//If ib_just_open Then
//	ib_just_open = False
//	return
//End If
//If currentrow < 1 Then return
////---------------------------- APPEON END ----------------------------
//
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
//
// ii_parent_facility_id = ii_org_parent   //Start Code Change ----07.15.2015 #V15 maha - for facility specifc screens
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

