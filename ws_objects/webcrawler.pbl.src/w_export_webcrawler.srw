$PBExportHeader$w_export_webcrawler.srw
forward
global type w_export_webcrawler from window
end type
type cb_4 from commandbutton within w_export_webcrawler
end type
type dw_list from datawindow within w_export_webcrawler
end type
type dw_web_comp from datawindow within w_export_webcrawler
end type
type dw_step_comp from datawindow within w_export_webcrawler
end type
type dw_steps from datawindow within w_export_webcrawler
end type
type st_status1 from statictext within w_export_webcrawler
end type
type st_7 from statictext within w_export_webcrawler
end type
type cb_1 from commandbutton within w_export_webcrawler
end type
type st_2 from statictext within w_export_webcrawler
end type
type cb_3 from commandbutton within w_export_webcrawler
end type
type dw_hdr from datawindow within w_export_webcrawler
end type
type dw_ent_link from datawindow within w_export_webcrawler
end type
type cb_2 from commandbutton within w_export_webcrawler
end type
type gb_3 from groupbox within w_export_webcrawler
end type
end forward

global type w_export_webcrawler from window
integer x = 1056
integer y = 484
integer width = 3241
integer height = 1884
boolean titlebar = true
string title = "Export WebCrawlers"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_4 cb_4
dw_list dw_list
dw_web_comp dw_web_comp
dw_step_comp dw_step_comp
dw_steps dw_steps
st_status1 st_status1
st_7 st_7
cb_1 cb_1
st_2 st_2
cb_3 cb_3
dw_hdr dw_hdr
dw_ent_link dw_ent_link
cb_2 cb_2
gb_3 gb_3
end type
global w_export_webcrawler w_export_webcrawler

type variables
String is_app_path
String is_app_path_only

end variables

forward prototypes
public function integer of_clear_annos (long ii_app_id)
public function string of_check_4_dupe_name (long ai_app, string as_name)
public subroutine of_import_code ()
public function integer of_delete_existing (long al_crawl)
end prototypes

public function integer of_clear_annos (long ii_app_id);//String ls_group
//String ls_label_data
//String ls_field_description
//String ls_object_type
//String ls_field_type
//String ls_lookup_link_type
//String ls_group_nm
//String ls_fld_desc
//String ls_lookup_link_field
//String ls_fld_display
//String ls_font_type
//Long ll_field_id
//Long ll_table_id
//Long li_field_len
//long li_app_field_id //modified 071802 maha
//String ls_fld_nm
//String ls_tbl_nm
//long li_fld_cnt
//Long li_x_pos
//Long li_y_pos
//Long li_fld_loop
//Long li_prev_scrollY
//Long li_prev_scrollX
//Long li_cnt
//Integer p
//INTEGER LI_PAGE_CNT
//Integer li_current_page
//
////Start Code Change ---- 04.14.2006 #391 maha trap 5207
//if not fileexists(is_app_path + String( ii_app_id ) + ".tif") then
//	messagebox("","Unable to find file for importing: " + is_app_path + String( ii_app_id ) + ".tif")
//	return 0
//end if
////End Code Change---04.14.2006
//
//ole_edit.Object.Image( is_app_path + String( ii_app_id ) + ".tif" )
//
//li_page_cnt = ole_edit.Object.PageCount()
//
//FOR p = 1 TO li_page_cnt
//
//	st_status.Text = "Clearing annotations from application " + String( ii_app_id ) + ".tif page " + String( p ) + " of " + String( li_page_cnt ) + "   " + String( ii_app_id  )
//
////	li_current_page = ole_edit.Object.PageCount( ) 
////	messagebox
////
////	IF p > li_current_page THEN
////		messagebox(string( p ), string( li_current_page) )
////		Continue
////	END IF
////
//	ole_edit.Object.Page( p )
//	ole_edit.Object.Display()
//	
//	//IF ole_edit.Object.PageType <> 1 THEN
//	//	ole_edit.Object.ConvertPageType( 1 )
//	//END IF
//
//	li_prev_scrollY = ole_edit.object.ScrollPositionY( )
//	li_prev_scrollX = ole_edit.object.ScrollPositionX( )
//
//	ole_edit.object.ScrollPositionX( 0 )		
//	ole_edit.object.ScrollPositionY( 0 )			
//
//	dw_2.SetFilter( "app_id = " + String( ii_app_id ) + " AND page = " + String(p) )
//	dw_2.Filter( )
//
//	li_fld_cnt = dw_2.RowCount( )
//
//	FOR li_fld_loop = 1 TO li_fld_cnt
//		ole_edit.object.Annotationtype(11)	
//		ls_object_type = dw_2.GetItemString( li_fld_loop, "object_type" )
//		li_app_field_id = dw_2.GetItemNumber( li_fld_loop, "app_field_id" )
//		ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id))				
//		li_field_len = dw_2.GetItemNumber( li_fld_loop, "width" )
//		li_x_pos = dw_2.GetItemNumber( li_fld_loop, "x_pos" )
//		li_y_pos = dw_2.GetItemNumber( li_fld_loop, "y_pos" )
//		ll_field_id = dw_2.GetItemNumber( li_fld_loop, "field_id" )	
//		ll_table_id = dw_2.GetItemNumber( li_fld_loop, "table_id" )	
//		ls_field_description = dw_2.GetItemString( li_fld_loop, "field_description" )	
//		
//		IF ll_table_id = 99 THEN
//			CHOOSE CASE Upper( ls_field_description )
//				CASE "TODAYS DATE"
//					ole_edit.Object.DeleteAnnotationGroup( "SP-TODAYSDATE," + String( li_app_field_id ) )		
//				CASE "CURRENT TIME"
//					ole_edit.Object.DeleteAnnotationGroup( "SP-CURRENTTIME," + String( li_app_field_id ))				
//				CASE "USER ID"
//					ole_edit.Object.DeleteAnnotationGroup( "SP-USERID," + String( li_app_field_id ))		
//			END CHOOSE
//			ole_edit.object.Annotationtype(11)
//			//Start Code Change ---- 03.22.2006 #338 maha
//			try
//			IF Mid( Upper ( ls_field_description ), 1, 5 ) = "LABEL" THEN
//				ls_label_data =  Mid( ls_field_description, 7, 100 ) 
//				ls_group = "LABEL-" + Mid(ls_label_data, 1, 20 ) + ";" + String( li_app_field_id )
//				ole_edit.Object.DeleteAnnotationGroup( ls_group )		
//				ls_group = "LABEL-" + Mid(ls_label_data, 1, 5 ) + ";" + String( li_app_field_id )
//				ole_edit.Object.DeleteAnnotationGroup( ls_group ) //maha 031405
//			ELSEIF Upper( ls_field_description) = "RECTANGLE" THEN
//				ole_edit.Object.DeleteAnnotationGroup( "Rectangle," + String( li_app_field_id ))		
//			ELSEIF Upper( ls_field_description) = "HOLLOWRECTANGLE" THEN
//				ole_edit.Object.DeleteAnnotationGroup( "HollowRectangle," + String( li_app_field_id ))						
//			END IF
//			CATCH (RunTimeError rte)
//			END TRY
//			//End Code Change---03.22.2006
//			ole_edit.object.Annotationtype(11)	
//			ole_edit.object.AnnotationFontColor(255)
//			ole_edit.object.Annotationtype(8)		
//			CHOOSE CASE dw_2.GetItemNumber( li_fld_loop, "font_size" )
//				CASE 1
//					ole_edit.object.AnnotationFont.Name = "MS Serif"
//					ole_edit.object.AnnotationFont.Size = 7
//				CASE 2
//					ole_edit.object.AnnotationFont.Name = "Times New Roman"
//					ole_edit.object.AnnotationFont.Size = 8				
//				CASE 3
//					ole_edit.object.AnnotationFont.Name = "Times New Roman"
//					ole_edit.object.AnnotationFont.Size = 12			
//			END CHOOSE
//			IF dw_2.GetItemNumber( li_fld_loop, "font_bold" ) = 1 THEN
//				ole_edit.object.AnnotationFont.Bold = True
//			ELSE
//				ole_edit.object.AnnotationFont.Bold = False
//			END IF
//			CONTINUE
//		END IF
//	
//	//w_train_app.st_field.Text = ls_tbl_nm + "->" + ls_fld_nm
//	CHOOSE CASE ls_object_type
//		CASE "T"
//			//ls_field_type = dw_2.GetItemString( li_fld_loop, "sys_fields_field_type" )
//			ls_lookup_link_type = dw_2.GetItemString( li_fld_loop, "lookup_link_type" )
//			ls_lookup_link_field = dw_2.GetItemString( li_fld_loop, "lookup_link_field" )
//			IF ls_lookup_link_type = "A" OR ls_lookup_link_type = "C" THEN
//				ls_field_type = "C"			
//			END IF
//		CHOOSE CASE Upper( ls_field_type )
//			CASE "C"
//				ls_fld_display = Fill( "x", li_field_len )
//			CASE "I"
//				ls_fld_display = Fill( "#", li_field_len )				
//			CASE "D"
//				ls_fld_display = "mm/dd/yyyy"
//			CASE "N"
//				ls_fld_display = Fill( "#", li_field_len )								
//		END CHOOSE
//					
//		ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) )
//		ole_edit.object.Annotationtype(11)	
//	CASE "B"
//		ole_edit.Object.DeleteAnnotationGroup( dw_2.GetItemNumber( dw_2.GetRow(), "field_id" ) )
//		ole_edit.object.Annotationtype(3)
//		//ole_edit.object.Draw(li_x_pos, li_y_pos, 20,20)
//		ole_edit.object.Annotationtype(11)			
//	CASE "Y1"
//		//yes box
//		ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesBox")
//		ole_edit.object.Annotationtype(3)
//		ole_edit.object.AnnotationLineColor( 255 )		
//		//ole_edit.object.Draw(li_x_pos, li_y_pos, 20,20)
//		
//		//no
//		ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "NoBox")
//		ole_edit.object.AnnotationLineColor( 0 )
//		//ole_edit.object.Draw(li_x_pos + 30, li_y_pos, 20,20)		
//		ole_edit.object.Annotationtype(11)					
//	CASE "Y2"
//		//yes box
//		ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesCheck")
//		ole_edit.object.AnnotationStampText( "X" )
//		ole_edit.object.Annotationtype(8)
//		//ole_edit.object.Draw(li_x_pos, li_y_pos, 10,10)		
//		ole_edit.object.Annotationtype(11)							
//	CASE "C"		
//		ole_edit.Object.DeleteAnnotationGroup( String( li_app_field_id ) + "Check" )
//		ole_edit.object.Annotationtype(11)									
//	END CHOOSE
//END FOR
//	ole_edit.Object.Save()
//END FOR
//
//ole_edit.object.ScrollPositionX( li_prev_scrollX )		
//ole_edit.object.ScrollPositionY( li_prev_scrollY )			
//ole_edit.object.Annotationtype(11)		
//
//dw_2.SetFilter( "" )
//dw_2.Filter( )
//
//ole_edit.Object.ClearDisplay( )

Return 0
end function

public function string of_check_4_dupe_name (long ai_app, string as_name);//maha 072004 called from clicked of cb_1

integer cnt
string ls_name
string ls_return
string res
string s
string ls_new
long ll_app

ls_name = as_name

select count( application_name) into : cnt from app_hdr where application_name = :ls_name;

if cnt > 0 then
	openwithparm(w_app_dupe_choices,ls_name)
	res = message.stringparm
	s = MidA(res,1,1)
	if s = "N" then
		ls_return = res
	elseif s = "O" then //if rename old
		ls_new = MidA(res,3)
		select app_id into :ll_app from app_hdr where application_name = :ls_name;
		update app_hdr 
		set application_name = :ls_new
		where app_id = :ll_app;
		commit using sqlca;
		ls_return = "C"
	else
		ls_return = "C"
	end if
else
	ls_return = "C"
end if







return ls_return

end function

public subroutine of_import_code ();//code not being used; was original trapping for existing records

datawindow ldw_imp

integer r
integer res
long org_id[]
long new_id[]
long ll_max
long rec_org
long i
long ic
long w
string ls_path
string ls_file

select Max(wc_id) into :ll_max from wc_hdr;

ls_path = gs_temp_path
r = GetFolder ( "Browse to folder where the import files are.", ls_path )
if r = 0 then return //cancel
if MidA(ls_path,LenA(ls_path),1) <> "\" then ls_path += "\"

for r = 1 to 5 //for each datawindow
	choose case r
		case 1
			ldw_imp = dw_hdr
			ls_file = "wc_hdr_imp.txt"
		case 2
			ldw_imp = dw_ent_link
			ls_file = "wc_ent_imp.txt"
		case 3
			ldw_imp = dw_steps
			ls_file = "wc_stp_imp.txt"
		case 4
			ldw_imp = dw_step_comp
			ls_file = "wc_stpcomp_imp.txt"
		case 5
			ldw_imp = dw_web_comp
			ls_file = "wc_webcomp_imp.txt"
	end choose
	ls_file = ls_path + ls_file
	if not fileexists(ls_file) then
		messagebox("Import Failure","Unable to find file " + ls_file )
		return
	end if
	res = ldw_imp.importfile( ls_file )
	if res < 1 then
		messagebox("Import Failure","Unable to Import file " + ls_file )
		return
	end if
	ic = ldw_imp.rowcount()
	ldw_imp.sort()
	for i = 1 to ic //list of imported records
		rec_org = ldw_imp.getitemnumber(i,"wc_id")
		if r = 1 then //the header dw get and set the crawler id
			org_id[i] = rec_org
			ll_max++
			new_id[i] = ll_max
			ldw_imp.setitem(i,"wc_id",ll_max)
		else //all the child data
			for w = 1 to upperbound(org_id) // if match to the org id chnage to the new id
				if rec_org = org_id[w] then
					ldw_imp.setitem(i,"wc_id",new_id[w])
					exit
				end if
			next //orgid
		end if
	next //record
	if ldw_imp.update() < 1 then //save failure
		messagebox("Import Failure","Update failure in dw_" + string(r) )
		rollback using sqlca;
		return
	end if
	
next //case

commit using sqlca;
end subroutine

public function integer of_delete_existing (long al_crawl);integer li_val

select count(wc_id) into: li_val from wc_hdr where wc_id = :al_crawl;
if li_val > 0 then
	return 0
else
	delete from wc_entity_multi_link where wc_id = :al_crawl;
	delete from wc_steps where wc_id = :al_crawl;
	delete from wc_steps_extracted_data_comparison where wc_id = :al_crawl;
	delete from wc_web_data_comparison where wc_id = :al_crawl;
	delete from wc_hdr where wc_id = :al_crawl;
	//commit using sqlca;
	return 1
end if

end function

on w_export_webcrawler.create
this.cb_4=create cb_4
this.dw_list=create dw_list
this.dw_web_comp=create dw_web_comp
this.dw_step_comp=create dw_step_comp
this.dw_steps=create dw_steps
this.st_status1=create st_status1
this.st_7=create st_7
this.cb_1=create cb_1
this.st_2=create st_2
this.cb_3=create cb_3
this.dw_hdr=create dw_hdr
this.dw_ent_link=create dw_ent_link
this.cb_2=create cb_2
this.gb_3=create gb_3
this.Control[]={this.cb_4,&
this.dw_list,&
this.dw_web_comp,&
this.dw_step_comp,&
this.dw_steps,&
this.st_status1,&
this.st_7,&
this.cb_1,&
this.st_2,&
this.cb_3,&
this.dw_hdr,&
this.dw_ent_link,&
this.cb_2,&
this.gb_3}
end on

on w_export_webcrawler.destroy
destroy(this.cb_4)
destroy(this.dw_list)
destroy(this.dw_web_comp)
destroy(this.dw_step_comp)
destroy(this.dw_steps)
destroy(this.st_status1)
destroy(this.st_7)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.dw_hdr)
destroy(this.dw_ent_link)
destroy(this.cb_2)
destroy(this.gb_3)
end on

event open;dw_hdr.settransobject(sqlca)
dw_ent_link.settransobject(sqlca)
dw_steps.settransobject(sqlca)
dw_step_comp.settransobject(sqlca)
dw_web_comp.settransobject(sqlca)

dw_list.settransobject(sqlca)
dw_list.retrieve()
end event

type cb_4 from commandbutton within w_export_webcrawler
integer x = 14
integer y = 1668
integer width = 347
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;integer val
integer i

if this.text = "Select All" then
	val = 1
	this .text = "Deselect All"
else
	val = 0
	this .text = "Select All"
end if

for i = 1 to dw_list.rowcount()
	dw_list.setitem(i,"selected",val)
next
end event

type dw_list from datawindow within w_export_webcrawler
integer x = 14
integer y = 348
integer width = 3177
integer height = 1312
integer taborder = 30
string title = "none"
string dataobject = "d_wc_hdr_exp_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_web_comp from datawindow within w_export_webcrawler
integer x = 1289
integer y = 1968
integer width = 288
integer height = 400
integer taborder = 100
string title = "none"
string dataobject = "d_web_data_comp_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_step_comp from datawindow within w_export_webcrawler
integer x = 1010
integer y = 1968
integer width = 233
integer height = 400
integer taborder = 90
string title = "none"
string dataobject = "d_wc_steps_extract_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_steps from datawindow within w_export_webcrawler
integer x = 704
integer y = 1944
integer width = 201
integer height = 400
integer taborder = 90
string title = "none"
string dataobject = "d_wc_steps_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_status1 from statictext within w_export_webcrawler
integer x = 82
integer y = 224
integer width = 1179
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type st_7 from statictext within w_export_webcrawler
integer x = 87
integer y = 68
integer width = 2240
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "1) Select Desired Crawlers"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_export_webcrawler
integer x = 2661
integer y = 144
integer width = 475
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export Crawlers"
end type

event clicked;datawindow ldw_imp
integer r
integer c
integer res
integer cnt
long org_id[]
long new_id[]
long ll_max
long rec_org
long i
long ic
long w
string ls_path
string ls_file

ls_path = gs_temp_path
r = GetFolder ( "Browse to folder where you wish to save the export files.", ls_path )
if r = 0 then return //cancel
if MidA(ls_path,LenA(ls_path),1) <> "\" then ls_path += "\"


ic = dw_list.rowcount()
if ic = 0 then return

c = 0

for i = 1 to ic
	if dw_list.getitemnumber(i,"selected") =  1 then
		c++
		org_id[c] = dw_list.getitemnumber(i,"wc_id")
		//messagebox("",org_id[c])
	end if
next

if r = 0 then
	messagebox("","No Crawlers Selected")
	return
end if
	
	debugbreak()
//retrieve the list items for each dw and export.
dw_hdr.retrieve(org_id)
dw_ent_link.retrieve(org_id)	
dw_steps.retrieve(org_id)
dw_step_comp.retrieve(org_id)
dw_web_comp.retrieve(org_id)


	
for r = 1 to 5 //for each datawindow
	 
	choose case r
		case 1
			ldw_imp = dw_hdr
			ls_file = "wc_hdr_imp.txt"
		case 2
			ldw_imp = dw_ent_link
			ls_file = "wc_ent_imp.txt"
			continue
		case 3
			ldw_imp = dw_steps
			ls_file = "wc_stp_imp.txt"
		case 4
			ldw_imp = dw_step_comp
			ls_file = "wc_stpcomp_imp.txt"
		case 5
			ldw_imp = dw_web_comp
			ls_file = "wc_webcomp_imp.txt"
	end choose
	cnt = ldw_imp.rowcount()
	
	ls_file = ls_path + ls_file
	ldw_imp.SaveAs ( ls_file, text!, False )
	
next //case


st_status1.text = string(c) + " Web Crawlers Exported."





end event

type st_2 from statictext within w_export_webcrawler
integer x = 82
integer y = 152
integer width = 2290
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "2) Click on the Export Crawlers Button."
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_export_webcrawler
boolean visible = false
integer x = 1755
integer y = 2056
integer width = 521
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Extract Zip File"
end type

event clicked;String ls_app_path
String k

SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

RUN( ls_app_path + "intelliapps.exe" )
end event

type dw_hdr from datawindow within w_export_webcrawler
integer x = 59
integer y = 1980
integer width = 288
integer height = 340
integer taborder = 80
string dataobject = "d_wc_hdr_exp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ent_link from datawindow within w_export_webcrawler
integer x = 379
integer y = 1968
integer width = 261
integer height = 360
integer taborder = 90
string dataobject = "d_wc_imp_entity_link"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_export_webcrawler
integer x = 2661
integer y = 40
integer width = 475
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type gb_3 from groupbox within w_export_webcrawler
integer x = 37
integer width = 2414
integer height = 324
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Export Webview Mappings"
end type

