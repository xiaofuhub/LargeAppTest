$PBExportHeader$w_import_webcrawler.srw
forward
global type w_import_webcrawler from window
end type
type st_9 from statictext within w_import_webcrawler
end type
type st_8 from statictext within w_import_webcrawler
end type
type st_4 from statictext within w_import_webcrawler
end type
type rb_3 from radiobutton within w_import_webcrawler
end type
type rb_2 from radiobutton within w_import_webcrawler
end type
type rb_1 from radiobutton within w_import_webcrawler
end type
type cb_import from commandbutton within w_import_webcrawler
end type
type cbx_comp from checkbox within w_import_webcrawler
end type
type cbx_extract from checkbox within w_import_webcrawler
end type
type cbx_steps from checkbox within w_import_webcrawler
end type
type cbx_links from checkbox within w_import_webcrawler
end type
type cbx_hdr from checkbox within w_import_webcrawler
end type
type cb_update from commandbutton within w_import_webcrawler
end type
type st_3 from statictext within w_import_webcrawler
end type
type st_1 from statictext within w_import_webcrawler
end type
type dw_web_comp from datawindow within w_import_webcrawler
end type
type dw_step_comp from datawindow within w_import_webcrawler
end type
type dw_steps from datawindow within w_import_webcrawler
end type
type st_status1 from statictext within w_import_webcrawler
end type
type st_7 from statictext within w_import_webcrawler
end type
type cb_4 from commandbutton within w_import_webcrawler
end type
type cb_go from commandbutton within w_import_webcrawler
end type
type st_5 from statictext within w_import_webcrawler
end type
type st_2 from statictext within w_import_webcrawler
end type
type cb_3 from commandbutton within w_import_webcrawler
end type
type st_status from statictext within w_import_webcrawler
end type
type dw_hdr from datawindow within w_import_webcrawler
end type
type dw_ent_link from datawindow within w_import_webcrawler
end type
type cb_2 from commandbutton within w_import_webcrawler
end type
type st_6 from statictext within w_import_webcrawler
end type
type gb_3 from groupbox within w_import_webcrawler
end type
type dw_hrd_copy from datawindow within w_import_webcrawler
end type
type gb_1 from groupbox within w_import_webcrawler
end type
type gb_2 from groupbox within w_import_webcrawler
end type
end forward

global type w_import_webcrawler from window
integer x = 1056
integer y = 484
integer width = 2505
integer height = 1280
boolean titlebar = true
string title = "Import Web Crawls"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 33551856
st_9 st_9
st_8 st_8
st_4 st_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_import cb_import
cbx_comp cbx_comp
cbx_extract cbx_extract
cbx_steps cbx_steps
cbx_links cbx_links
cbx_hdr cbx_hdr
cb_update cb_update
st_3 st_3
st_1 st_1
dw_web_comp dw_web_comp
dw_step_comp dw_step_comp
dw_steps dw_steps
st_status1 st_status1
st_7 st_7
cb_4 cb_4
cb_go cb_go
st_5 st_5
st_2 st_2
cb_3 cb_3
st_status st_status
dw_hdr dw_hdr
dw_ent_link dw_ent_link
cb_2 cb_2
st_6 st_6
gb_3 gb_3
dw_hrd_copy dw_hrd_copy
gb_1 gb_1
gb_2 gb_2
end type
global w_import_webcrawler w_import_webcrawler

type variables
String is_app_path
String is_app_path_only
boolean ib_hdr
boolean ib_links
boolean ib_steps
boolean ib_extract
boolean ib_comp
end variables

forward prototypes
public function integer of_clear_annos (long ii_app_id)
public function string of_check_4_dupe_name (long ai_app, string as_name)
public subroutine of_import_code ()
public function integer of_delete_existing (long al_crawl)
public function integer of_reset ()
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

public function string of_check_4_dupe_name (long ai_app, string as_name);
return ""

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

if ib_links = true then 
	delete from wc_multi_entity_link where wc_id = :al_crawl; //42007
end if

if ib_steps then
	delete from wc_steps where wc_id = :al_crawl;
end if

if ib_extract then
	delete from wc_steps_extracted_data_comparison where wc_id = :al_crawl;
end if

if ib_comp then
	delete from wc_web_data_comparison where wc_id = :al_crawl;
end if
	
commit using sqlca;

if ib_hdr then
	delete from wc_hdr where wc_id = :al_crawl; 
	commit using sqlca;
end if

commit using sqlca;

select count(wc_id) into :li_val from wc_hdr where wc_id = :al_crawl;
//messagebox(string(al_crawl),li_val)
if li_val > 0 then
	messagebox("Delete Existing","Did not delete crawler # " + string(al_crawl))
end if
	
return 1


end function

public function integer of_reset ();//maha 080807
cbx_hdr.enabled = true
cbx_links.enabled = true
cbx_steps.enabled = true
cbx_extract.enabled = true
cbx_comp.enabled = true

dw_ent_link.reset()
dw_hdr.reset()
dw_step_comp.reset()
dw_steps.reset()
dw_web_comp.reset()

cb_import.enabled = true
cb_update.enabled = false
cb_go.enabled = false



return 1
end function

on w_import_webcrawler.create
this.st_9=create st_9
this.st_8=create st_8
this.st_4=create st_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_import=create cb_import
this.cbx_comp=create cbx_comp
this.cbx_extract=create cbx_extract
this.cbx_steps=create cbx_steps
this.cbx_links=create cbx_links
this.cbx_hdr=create cbx_hdr
this.cb_update=create cb_update
this.st_3=create st_3
this.st_1=create st_1
this.dw_web_comp=create dw_web_comp
this.dw_step_comp=create dw_step_comp
this.dw_steps=create dw_steps
this.st_status1=create st_status1
this.st_7=create st_7
this.cb_4=create cb_4
this.cb_go=create cb_go
this.st_5=create st_5
this.st_2=create st_2
this.cb_3=create cb_3
this.st_status=create st_status
this.dw_hdr=create dw_hdr
this.dw_ent_link=create dw_ent_link
this.cb_2=create cb_2
this.st_6=create st_6
this.gb_3=create gb_3
this.dw_hrd_copy=create dw_hrd_copy
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_9,&
this.st_8,&
this.st_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_import,&
this.cbx_comp,&
this.cbx_extract,&
this.cbx_steps,&
this.cbx_links,&
this.cbx_hdr,&
this.cb_update,&
this.st_3,&
this.st_1,&
this.dw_web_comp,&
this.dw_step_comp,&
this.dw_steps,&
this.st_status1,&
this.st_7,&
this.cb_4,&
this.cb_go,&
this.st_5,&
this.st_2,&
this.cb_3,&
this.st_status,&
this.dw_hdr,&
this.dw_ent_link,&
this.cb_2,&
this.st_6,&
this.gb_3,&
this.dw_hrd_copy,&
this.gb_1,&
this.gb_2}
end on

on w_import_webcrawler.destroy
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_import)
destroy(this.cbx_comp)
destroy(this.cbx_extract)
destroy(this.cbx_steps)
destroy(this.cbx_links)
destroy(this.cbx_hdr)
destroy(this.cb_update)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.dw_web_comp)
destroy(this.dw_step_comp)
destroy(this.dw_steps)
destroy(this.st_status1)
destroy(this.st_7)
destroy(this.cb_4)
destroy(this.cb_go)
destroy(this.st_5)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.st_status)
destroy(this.dw_hdr)
destroy(this.dw_ent_link)
destroy(this.cb_2)
destroy(this.st_6)
destroy(this.gb_3)
destroy(this.dw_hrd_copy)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;dw_hdr.settransobject(sqlca)
dw_ent_link.settransobject(sqlca)
dw_steps.settransobject(sqlca)
dw_step_comp.settransobject(sqlca)
dw_web_comp.settransobject(sqlca)
dw_hrd_copy.settransobject(sqlca)
end event

type st_9 from statictext within w_import_webcrawler
integer x = 73
integer y = 556
integer width = 2290
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "6) Click on the Update Crawlers Button to update data."
boolean focusrectangle = false
end type

type st_8 from statictext within w_import_webcrawler
integer x = 73
integer y = 420
integer width = 2290
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "4) Manually change Checkboxes if desired.  Unchecked data will not be overwritten."
boolean focusrectangle = false
end type

type st_4 from statictext within w_import_webcrawler
integer x = 73
integer y = 352
integer width = 2290
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "3) Select Import type to set update checkboxes."
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_import_webcrawler
integer x = 110
integer y = 1016
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Both"
end type

event clicked;cbx_hdr.checked = false
cbx_links.checked = true
cbx_steps.checked = true
cbx_extract.checked = true
cbx_comp.checked = true

of_reset( )
end event

type rb_2 from radiobutton within w_import_webcrawler
integer x = 110
integer y = 896
integer width = 750
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Updating Existing Crawls "
end type

event clicked;cbx_hdr.checked = false
cbx_links.checked = false
cbx_steps.checked = true
cbx_extract.checked = true
cbx_comp.checked = false

of_reset( )
end event

type rb_1 from radiobutton within w_import_webcrawler
integer x = 110
integer y = 784
integer width = 425
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Adding New"
boolean checked = true
end type

event clicked;cbx_hdr.checked = true
cbx_links.checked = true
cbx_steps.checked = true
cbx_extract.checked = true
cbx_comp.checked = true

of_reset( )

//cbx_hdr.enabled = true
//cbx_links.enabled = true
//cbx_steps.enabled = true
//cbx_extract.enabled = true
//cbx_comp.enabled = true
//
//cb_import.enabled = true
//cb_update.enabled = false
//cb_go.enabled = false
//





end event

type cb_import from commandbutton within w_import_webcrawler
integer x = 425
integer y = 36
integer width = 475
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Import Crawlers"
end type

event clicked;datawindow ldw_imp

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
long ec
integer f
integer te
integer cn
boolean lb_imp

select Max(wc_id) into :ll_max from wc_hdr;

ls_path = gs_temp_path
r = GetFolder ( "Browse to folder where the import files are.", ls_path )
if r = 0 then return //cancel
if MidA(ls_path,LenA(ls_path),1) <> "\" then ls_path += "\"

ec = dw_hrd_copy.retrieve()

cbx_hdr.enabled = False
cbx_links.enabled = False
cbx_steps.enabled = False
cbx_extract.enabled = False
cbx_comp.enabled = False

for r = 1 to 5 //for each datawindow
	lb_imp = false
	choose case r
		case 1
			if cbx_hdr.checked then 
				ib_hdr = true
			end if
			lb_imp = true  //always import the header even if they won't be updated
			ldw_imp = dw_hdr
			ls_file = "wc_hdr_imp.txt"
		case 2
			if cbx_links.checked then 
				ib_links = true
				lb_imp = true
			end if
			ldw_imp = dw_ent_link
			//continue	
			ls_file = "wc_ent_imp.txt"
		case 3
			if cbx_steps.checked then 
				ib_steps = true
				lb_imp = true
			end if	
			ldw_imp = dw_steps
			ls_file = "wc_stp_imp.txt"
		case 4
			if cbx_extract.checked then 
				ib_extract = true
				lb_imp = true
			end if	
			ldw_imp = dw_step_comp
			ls_file = "wc_stpcomp_imp.txt"
		case 5
			if cbx_comp.checked then 
				ib_comp = true
				lb_imp = true
			end if	
			ldw_imp = dw_web_comp
			ls_file = "wc_webcomp_imp.txt"
	end choose
	
	ls_file = ls_path + ls_file
	if lb_imp then
		if not fileexists(ls_file) then
	//		res = messagebox("Import Failure","Unable to find file " + ls_file + ".  Continue?",question!,yesno!,1 )
	//		if res = 2 then return
		end if
		res = ldw_imp.importfile( ls_file )
//		if res < 0 then //removed maha 09.12.07
//			res = messagebox("Import Failure","Unable to Import file " + ls_file + ".  Continue?",question!,yesno!,1 )
//			if res = 2 then return
//		end if
	end if
	
//	ic = ldw_imp.rowcount()
//	ldw_imp.sort()
//	if r = 1 then  //header data
//	debugbreak()
//		for i = 1 to ic //list of imported records
//			rec_org = ldw_imp.getitemnumber(i,"wc_id")
//			f = dw_hrd_copy.find("wc_id =" + string(rec_org),1,ec) //check existing
//			if f = 0 then //if the hdr file does not exist, copy.  protecting from overwriting login info //maha 042007
//				te = ldw_imp.rowscopy( i,i,Primary!,dw_hrd_copy  ,500, primary!)
//			elseif f < 0 then
//				messagebox("Web Crawler","Copy Header failure; Contact IntelliSoft Support.")
//			else
//				//leave alone
//			end if
//				
//			//identify existing crawler and delete
//			//messagebox("",rec_org)
//			of_delete_existing(rec_org)
//
//		next //record
//		if dw_hrd_copy.update() < 1 then //save failure
//			messagebox("Import Failure","Update failure in dw_" + string(r) )
//			rollback using sqlca;
//			return
//		else
//			commit using sqlca;
//		end if
//	else
//		cn = ldw_imp.update()
//		if cn < 1 then
//			messagebox("Update","Failure in " + ls_file + " update.")
//		end if
//	
//	end if
	
next //case

//commit using sqlca;

//cb_go.visible = true
//messagebox("Web Crawler","Your Crawls have been imported.  There may be needed setup for these Crawls such as login information and specific lookup links.  Click on the Go to Crawler Setup to do this.  You can access this painter later from System Utilities (Web Crawl Setup button)." )
//st_status1.text = "Web Crawlers Import process completed."

cb_update.enabled = true



end event

type cbx_comp from checkbox within w_import_webcrawler
integer x = 1317
integer y = 1032
integer width = 731
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update Comparison Data"
boolean checked = true
end type

type cbx_extract from checkbox within w_import_webcrawler
integer x = 1317
integer y = 964
integer width = 608
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update Extract data"
boolean checked = true
end type

type cbx_steps from checkbox within w_import_webcrawler
integer x = 1317
integer y = 900
integer width = 654
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update Steps"
boolean checked = true
end type

type cbx_links from checkbox within w_import_webcrawler
integer x = 1317
integer y = 832
integer width = 430
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update Links"
boolean checked = true
end type

type cbx_hdr from checkbox within w_import_webcrawler
integer x = 1317
integer y = 760
integer width = 910
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update Existing Crawler Header"
boolean checked = true
end type

type cb_update from commandbutton within w_import_webcrawler
integer x = 937
integer y = 36
integer width = 475
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Update Crawlers"
end type

event clicked;datawindow ldw_imp

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
long ec
integer f
integer te
integer cn
boolean lb_imp

//select Max(wc_id) into :ll_max from wc_hdr;

for r = 1 to 5
	choose case r
		case 1
			ldw_imp = dw_hdr
			ls_file = "Header"
		case 2
			if ib_links = false then continue	
			ldw_imp = dw_ent_link
			ls_file = "Entity Links"
		case 3
			if ib_steps = false then continue
			ldw_imp = dw_steps
			ls_file = "Crawler Steps"
		case 4
			if ib_extract  = false then continue
			ldw_imp = dw_step_comp
			ls_file = "Step Comparison"
		case 5
			if ib_comp = false then continue
			ldw_imp = dw_web_comp
			ls_file = "Site Comparison"
	end choose
			
	ic = ldw_imp.rowcount()
	ldw_imp.sort()
	if r = 1 then  //header data
	debugbreak()
		for i = 1 to ic //list of imported records
			rec_org = ldw_imp.getitemnumber(i,"wc_id")
			f = dw_hrd_copy.find("wc_id =" + string(rec_org),1,dw_hrd_copy.rowcount()) //check existing
			if f = 0 then //if the hdr file does not exist, copy.  protecting from overwriting login info //maha 042007
				te = ldw_imp.rowscopy( i,i,Primary!,dw_hrd_copy  ,5000, primary!)
			elseif f < 0 then //failure of find
				messagebox("Web Crawler Import","Copy Header failure; Contact IntelliSoft Support.")
			else //if header update is checked replace the existing record
				if ib_hdr then //Start Code Change ---- 09.12.2007 #V7 maha
					dw_hrd_copy.rowsdiscard( f, f, Primary!)
					ldw_imp.rowscopy( i,i,Primary!,dw_hrd_copy  ,5000, primary!)
				end if
			end if
				
			//identify existing crawler and delete
			//messagebox("",rec_org)
			of_delete_existing(rec_org)

		next //record
		if dw_hrd_copy.update() < 1 then //save failure
			messagebox("Import Failure","Update failure in header data." )
			rollback using sqlca;
			return
		else
			commit using sqlca;
		end if
	else
		if ldw_imp.rowcount() < 1 then continue //maha 081007
		cn = ldw_imp.update()
		if cn < 1 then
			messagebox("Update","Failure in " + ls_file + " update.")
		end if
	
	end if
	
next //case

commit using sqlca;

cb_go.visible = true
cb_go.enabled = true //maha 091207
messagebox("Web Crawler","Your Crawls have been imported.  There may be needed setup for these Crawls such as login information and specific lookup links.  Click on the Go to Crawler Setup to do this.  You can access this painter later from System Utilities (Web Crawl Setup button)." )
st_status1.text = "Web Crawlers Import process completed."





end event

type st_3 from statictext within w_import_webcrawler
integer x = 73
integer y = 284
integer width = 2290
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "2) Copy the files into your IntelliCred folder."
boolean focusrectangle = false
end type

type st_1 from statictext within w_import_webcrawler
integer x = 73
integer y = 488
integer width = 2290
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "5) Click on the Import Crawlers Button to import files."
boolean focusrectangle = false
end type

type dw_web_comp from datawindow within w_import_webcrawler
integer x = 1650
integer y = 2480
integer width = 288
integer height = 400
integer taborder = 100
string title = "none"
string dataobject = "d_web_data_comp_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_step_comp from datawindow within w_import_webcrawler
integer x = 1371
integer y = 2480
integer width = 233
integer height = 920
integer taborder = 90
string dataobject = "d_wc_steps_extract_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_steps from datawindow within w_import_webcrawler
integer x = 681
integer y = 2412
integer width = 507
integer height = 940
integer taborder = 90
string title = "none"
string dataobject = "d_wc_steps_imp"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_status1 from statictext within w_import_webcrawler
integer x = 1111
integer y = 1980
integer width = 873
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
boolean focusrectangle = false
end type

type st_7 from statictext within w_import_webcrawler
integer x = 46
integer y = 1908
integer width = 2240
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "2) Follow the directions on the web page to download the Crawlers."
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_import_webcrawler
integer x = 1330
integer y = 2264
integer width = 475
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go to Web Site"
end type

event clicked;string ls_url
Inet  iinet_base
string ls_path = "C:\"

messagebox("Sorry","Website not ready.")
return

ls_url = "http://www.intellisoftgroup.com/intelliapp/webcrawl.cfm?path=" + ls_path
if gi_citrix = 1 then
	of_open_web(ls_url)
else
	GetContextService("Internet", iinet_base)
	iinet_base.HyperlinkToURL(ls_url)
	
end if




end event

type cb_go from commandbutton within w_import_webcrawler
integer x = 1445
integer y = 36
integer width = 521
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Go to Crawler Setup"
end type

event clicked;open(w_web_crawler_user_info)
end event

type st_5 from statictext within w_import_webcrawler
integer y = 1792
integer width = 2240
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "1) Click on the Go To Web Site button to search for the application to download."
boolean focusrectangle = false
end type

type st_2 from statictext within w_import_webcrawler
integer x = 73
integer y = 216
integer width = 2290
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "1) Contact IntelliSoft Support to get import files"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_import_webcrawler
boolean visible = false
integer x = 1915
integer y = 2320
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

type st_status from statictext within w_import_webcrawler
integer x = 59
integer y = 2016
integer width = 2327
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_hdr from datawindow within w_import_webcrawler
integer x = 59
integer y = 2388
integer width = 288
integer height = 996
integer taborder = 80
string dataobject = "d_wc_hdr_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ent_link from datawindow within w_import_webcrawler
integer x = 375
integer y = 2408
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

type cb_2 from commandbutton within w_import_webcrawler
integer x = 1975
integer y = 36
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

type st_6 from statictext within w_import_webcrawler
integer x = 27
integer y = 2116
integer width = 2373
integer height = 144
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "To view a complete list of Web crawler Websites that are currently available from IntelliSoft Group Inc, click on the Go To Web Site button below."
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_import_webcrawler
integer x = 32
integer y = 140
integer width = 2414
integer height = 524
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 33551856
string text = "Import Webcrawler Data"
end type

type dw_hrd_copy from datawindow within w_import_webcrawler
integer x = 2478
integer y = 2144
integer width = 288
integer height = 1224
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_wc_hdr_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_import_webcrawler
integer x = 37
integer y = 684
integer width = 1161
integer height = 464
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Import Type"
end type

type gb_2 from groupbox within w_import_webcrawler
integer x = 1280
integer y = 684
integer width = 1161
integer height = 464
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Update Crawl Data"
end type

