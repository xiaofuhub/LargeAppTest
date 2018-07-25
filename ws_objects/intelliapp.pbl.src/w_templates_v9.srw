$PBExportHeader$w_templates_v9.srw
forward
global type w_templates_v9 from w_response
end type
type rb_2 from radiobutton within w_templates_v9
end type
type rb_1 from radiobutton within w_templates_v9
end type
type st_new1 from statictext within w_templates_v9
end type
type st_new3 from statictext within w_templates_v9
end type
type cb_new from commandbutton within w_templates_v9
end type
type cb_save from commandbutton within w_templates_v9
end type
type cb_apply from commandbutton within w_templates_v9
end type
type dw_templates from u_dw within w_templates_v9
end type
type sle_saveas from singlelineedit within w_templates_v9
end type
type st_1 from statictext within w_templates_v9
end type
type cb_close from commandbutton within w_templates_v9
end type
type cb_delete from commandbutton within w_templates_v9
end type
type gb_1 from groupbox within w_templates_v9
end type
type dw_temp_flds from u_dw within w_templates_v9
end type
type cb_del_field from commandbutton within w_templates_v9
end type
type cb_2 from commandbutton within w_templates_v9
end type
type cb_interview from commandbutton within w_templates_v9
end type
type gb_place from groupbox within w_templates_v9
end type
type st_new2 from statictext within w_templates_v9
end type
type dw_order from datawindow within w_templates_v9
end type
type gb_2 from groupbox within w_templates_v9
end type
type gb_hide from groupbox within w_templates_v9
end type
end forward

global type w_templates_v9 from w_response
integer x = 960
integer y = 388
integer width = 1961
integer height = 2816
string title = "Application Templates"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
rb_2 rb_2
rb_1 rb_1
st_new1 st_new1
st_new3 st_new3
cb_new cb_new
cb_save cb_save
cb_apply cb_apply
dw_templates dw_templates
sle_saveas sle_saveas
st_1 st_1
cb_close cb_close
cb_delete cb_delete
gb_1 gb_1
dw_temp_flds dw_temp_flds
cb_del_field cb_del_field
cb_2 cb_2
cb_interview cb_interview
gb_place gb_place
st_new2 st_new2
dw_order dw_order
gb_2 gb_2
gb_hide gb_hide
end type
global w_templates_v9 w_templates_v9

type variables
Integer il_copy_field_order[]

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.16.2006 By: LeiWei
//$<reason> Fix a defect.
n_ds ids_app_prop
n_ds ids_app_sect
Integer ii_ids_app_prop_i,ii_ids_app_prop_rc
Long il_next_id
Integer ii_rec_num = 1
Integer ii_place_mode	//1 place template //2 interview mode
Integer ii_dw_templates_i
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_place_template ()
public function integer of_place_template_ ()
public function integer of_place_template1 ()
public function integer of_place_template_end ()
public function integer of_place_template2 ()
end prototypes

public function integer of_place_template ();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.16.2006 By: LeiWei
//$<reason> Fix a defect.
/*
	//w_train_app.tab_1.tabpage_design.ole_edit.SetRedraw( False )
	Integer li_copy_cnt
	Integer li_font
	Integer li_rec_num = 1
	Integer i
	Long li_next_id
	Integer li_template_id
	Integer li_rc
	integer li_null //maha 042406
	long li_y
	long li_x
	Long li_field_ids[]
	n_ds lds_app_prop
	n_ds lds_app_sect
	
	lds_app_prop = CREATE n_ds
	lds_app_sect = CREATE n_ds
	
	lds_app_sect.DataObject = "d_app_field_properties_section_template"
	lds_app_sect.SetTransObject( w_train_app.tr_training_data )
	
	lds_app_prop.DataObject = "d_app_field_properties"
	lds_app_prop.SetTransObject( w_train_app.tr_training_data )
	
	li_template_id = dw_templates.GetItemNumber( dw_templates.GetRow(), "template_id" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-01
	//$<modify> 04.18.2006 By: Cao YongWang
	//$<reason> Performance tuning.w_section_templates
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	
	/*
	lds_app_sect.Retrieve( li_template_id )
	li_rc = lds_app_sect.RowCount()
	
	SELECT Max( app_field_id )  
	INTO :li_next_id  
	FROM app_field_prop
	USING w_train_app.tr_training_data;
	*/
	gnv_appeondb.of_startqueue()
	
	lds_app_sect.Retrieve( li_template_id )
	
	SELECT Max( app_field_id )  
	INTO :li_next_id  
	FROM app_field_prop
	USING w_train_app.tr_training_data;
	
	gnv_appeondb.of_commitqueue()
	
	li_rc = lds_app_sect.RowCount()
	//---------------------------- APPEON END ----------------------------
	
	w_train_app.ii_copy_fields = 1
	w_train_app.ib_loading_annotations = False
	
	setnull(li_null)//Start Code Change ---- 04.24.2006 #423 maha
	FOR i = 1 TO li_rc
			w_train_app.ib_click_position = True
			w_place_template_msg.st_fld.Text = lds_app_sect.GetItemSTring( i, "field_description" )
			
			IF NOT w_place_template_msg.cbx_all.Checked THEN
				w_place_template_msg.ddlb_font.SelectItem(  lds_app_sect.GetItemNumber( i, "font_size" ) )
				w_place_template_msg.em_rec.Text = String( lds_app_sect.GetItemNumber( i, "record_number" ) )	
			END IF
			DO WHILE w_train_app.ib_click_position
				Yield()
				IF Not IsValid( w_train_app ) THEN
					Return -1
				END IF
			LOOP
			IF w_train_app.ib_skip THEN
				w_train_app.ib_skip = False
				CONTINUE
			ELSEIF w_train_app.ib_skip_temp THEN
				w_train_app.ib_skip_temp = False		
				w_train_app.ib_click_position = True
				Return 0
			END IF
			
			li_next_id++
	
	//Start Code Change ---- 12.13.2005 #168 maha	
			li_y = w_train_app.ii_ancor_y -8
			li_x = w_train_app.ii_ancor_x
			li_y = li_y - w_train_app.tab_1.tabpage_design.ole_edit.object.ScrollPositiony( )
			li_y = li_y - w_train_app.tab_1.tabpage_design.ole_edit.object.ScrollPositionX( )
			//li_copy_cnt++
			//li_nr = dw_order.InsertRow( 0 )
			//dw_order.SetItem( li_nr, "field_id", 
			lds_app_sect.SetItem( i, "y_pos",  li_y  )
			lds_app_sect.SetItem( i, "x_pos",  li_x )	
	//End Code Change---12.13.2005
			lds_app_sect.SetItem( i, "page", w_train_app.ii_current_page )		
			lds_app_sect.SetItem( i, "app_id", w_train_app.ii_app_id  )	
			lds_app_sect.SetItem( i, "app_field_id", li_next_id )
			//Start Code Change ---- 04.24.2006 #423 maha  clear the connect values
			lds_app_sect.SetItem( i, "connect_field_id", li_null )			
			lds_app_sect.SetItem( i, "connect_field_sort", li_null )
			//End Code Change---04.24.2006
			CHOOSE CASE w_place_template_msg.ddlb_font.Text 	
				CASE "Small"
					li_font = 1
				CASE "Medium"	
					li_font = 2
				CASE "Large"		
					li_font = 3
			END CHOOSE
			lds_app_sect.SetItem( i, "font_size", li_font )	
			lds_app_sect.SetItem( i, "record_number", Integer( w_place_template_msg.em_rec.Text ) )		
			li_field_ids[ i ] = li_next_id 
			
	///Start Code Change ---- 12.05.2005 #160 maha	
			integer res
			res = lds_app_sect.RowsCopy( i, i, Primary!, lds_app_prop, 1, Primary!)
			if res = -1 then
				messagebox("Rowscopy error in of_place_template of w_section_templates", "Contact IntelliSoft Group support.")
				return -1 
			end if
			
			
	//End Code Change---12.05.2005
	
			lds_app_prop.Update( )
	
			COMMIT USING w_train_app.tr_training_data;
	
			w_train_app.ib_loading_annotations = False
			w_train_app.of_create_annotations( li_field_ids[ i ] )
			w_train_app.ib_loading_annotations = False
		
	END FOR
		
		
	//messagebox("", lds_app_prop.rowcount())
	lds_app_prop.SetSort( "x_pos A, y_pos A" )
	lds_app_prop.Sort()
	li_rc = lds_app_prop.RowCount( )
	FOR i = 1 TO li_rc
		w_train_app.is_selected_fields[ i ] = String( lds_app_prop.GetItemNumber( i, "app_field_id" ) )
	END FOR
		
	DO WHILE TRUE	
		IF dw_templates.GetItemNumber( dw_templates.GetRow(), "multi_record" ) = 1 THEN
			w_place_template_msg.cb_skip.Visible = False
			w_place_template_msg.cb_pause.Visible = False
			w_place_template_msg.cb_skip_temp.Visible = False		
			w_place_template_msg.ddlb_font.Visible = False		
			w_place_template_msg.st_font.Visible = False		
			w_place_template_msg.em_rec.Visible = False				
			w_place_template_msg.st_rec.Visible = False				
			w_place_template_msg.cbx_all.Visible = False				
			w_place_template_msg.st_click.Visible = False			
			w_place_template_msg.cb_yes.Visible = True
			w_place_template_msg.cb_no.Visible = True				
			w_place_template_msg.ib_wait_for_click = True
			w_place_template_msg.st_fld.text = "Would you like to place fields for an additional record for the current template?"		
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 04.06.2006 By: Liang QingShi
			//$<reason> Fix a defect.
			/*
			DO WHILE	w_place_template_msg.ib_wait_for_click 
				Yield()
			LOOP
			*/
			boolean lb_wait_for_click
			lb_wait_for_click = w_place_template_msg.ib_wait_for_click
			DO WHILE	lb_wait_for_click 
				Yield()
				if isvalid(w_place_template_msg) then
					lb_wait_for_click = w_place_template_msg.ib_wait_for_click
				end if
			LOOP
			//---------------------------- APPEON END ----------------------------
			w_place_template_msg.ib_wait_for_click = False
			w_place_template_msg.cb_pause.Visible = True		
			w_place_template_msg.cb_skip.Visible = True
			w_place_template_msg.cb_skip_temp.Visible = True		
			w_place_template_msg.ddlb_font.Visible = True		
			w_place_template_msg.st_font.Visible = True		
			w_place_template_msg.em_rec.Visible = True				
			w_place_template_msg.st_rec.Visible = True				
			w_place_template_msg.cbx_all.Visible = True				
			w_place_template_msg.st_click.Visible = True			
			w_place_template_msg.st_fld.text = ""		
			w_place_template_msg.cb_yes.Visible = False
			w_place_template_msg.cb_no.Visible = False		
			IF w_place_template_msg.ib_additional_rec = False THEN
				w_place_template_msg.ib_additional_rec = False			
				EXIT
			END IF
		ELSE
			li_rec_num = 1
			EXIT
		END IF
		li_rec_num++
		w_place_template_msg.cbx_all.Checked = True				
		w_place_template_msg.em_rec.Text = String( li_rec_num )	
		w_train_app.of_copy_fields()
	LOOP
	
	
	//w_train_app.of_save_load()
	
	
	
	
	
	Return 0
*/
//---------------------------- APPEON END ----------------------------

Integer li_template_id

IF NOT IsValid(ids_app_prop) THEN
	ids_app_prop = CREATE n_ds
	ids_app_sect = CREATE n_ds

	ids_app_sect.DataObject = "d_app_field_properties_section_template"
	ids_app_sect.SetTransObject( w_train_app.tr_training_data )
	
	ids_app_prop.DataObject = "d_app_field_properties"
	ids_app_prop.SetTransObject( w_train_app.tr_training_data )
END IF

ids_app_prop.Reset( )
ids_app_sect.Reset( )

li_template_id = dw_templates.GetItemNumber( dw_templates.GetRow(), "template_id" )

gnv_appeondb.of_startqueue()

ids_app_sect.Retrieve( li_template_id )

SELECT Max( app_field_id )  
INTO :il_next_id  
FROM app_field_prop
USING w_train_app.tr_training_data;

gnv_appeondb.of_commitqueue()

ii_ids_app_prop_i = 0
ii_ids_app_prop_rc = ids_app_sect.RowCount()
IF ii_ids_app_prop_rc = 0 THEN
	of_place_template_end()
	Return 0
END IF

w_train_app.ii_copy_fields = 1
w_train_app.ib_loading_annotations = False

of_place_template1()

Return 0


end function

public function integer of_place_template_ ();//w_train_app.tab_1.tabpage_design.ole_edit.SetRedraw( False )
Integer li_font
Integer li_rec_num = 1
Integer i
Long li_next_id
Integer li_template_id
Integer li_rc
Integer li_y
Integer li_x
Long li_field_ids[]
n_ds lds_app_prop
n_ds lds_app_sect

lds_app_prop = CREATE n_ds
lds_app_sect = CREATE n_ds

lds_app_sect.DataObject = "d_app_field_properties_section_template"
lds_app_sect.SetTransObject( w_train_app.tr_training_data )

lds_app_prop.DataObject = "d_app_field_properties"
lds_app_prop.SetTransObject( w_train_app.tr_training_data )

li_template_id = dw_templates.GetItemNumber( dw_templates.GetRow(), "template_id" )

lds_app_sect.Retrieve( li_template_id )
li_rc = lds_app_sect.RowCount()

SELECT Max( app_field_id )  
INTO :li_next_id  
FROM app_field_prop
USING w_train_app.tr_training_data;

DO WHILE TRUE
	FOR i = 1 TO li_rc
		w_train_app.ib_click_position = True
		w_place_template_msg.st_fld.Text = lds_app_sect.GetItemSTring( i, "field_description" )
		IF NOT w_place_template_msg.cbx_all.Checked THEN
			w_place_template_msg.ddlb_font.SelectItem(  lds_app_sect.GetItemNumber( i, "font_size" ) )
			w_place_template_msg.em_rec.Text = String( lds_app_sect.GetItemNumber( i, "record_number" ) )	
		END IF
		DO WHILE w_train_app.ib_click_position
			Yield()
		LOOP
		IF w_train_app.ib_skip THEN
			w_train_app.ib_skip = False
			CONTINUE
		ELSEIF w_train_app.ib_skip_temp THEN
			w_train_app.ib_skip_temp = False		
			Return 0
		END IF
		
		li_next_id++
		li_y = lds_app_sect.GetItemNumber( i, "y_pos" )
		li_x = lds_app_sect.GetItemNumber( i, "x_pos" )
		lds_app_sect.SetItem( i, "y_pos",  w_train_app.ii_ancor_y -8   )
		lds_app_sect.SetItem( i, "x_pos",  w_train_app.ii_ancor_x  )	
		lds_app_sect.SetItem( i, "page", w_train_app.ii_current_page )		
		lds_app_sect.SetItem( i, "app_id", w_train_app.ii_app_id  )	
		lds_app_sect.SetItem( i, "app_field_id", li_next_id )	
		CHOOSE CASE w_place_template_msg.ddlb_font.Text 	
			CASE "Small"
				li_font = 1
			CASE "Medium"	
				li_font = 2
			CASE "Large"		
				li_font = 3
		END CHOOSE
		lds_app_sect.SetItem( i, "font_size", li_font )	
		lds_app_sect.SetItem( i, "record_number", Integer( w_place_template_msg.em_rec.Text ) )		
		li_field_ids[ i ] = li_next_id 
		
		lds_app_sect.RowsCopy( i, i, Primary!, lds_app_prop, 1, Primary!)

		lds_app_prop.Update( )

		COMMIT USING w_train_app.tr_training_data;

		w_train_app.of_create_annotations( li_field_ids[ i ] )
	
	END FOR
	IF dw_templates.GetItemNumber( dw_templates.GetRow(), "multi_record" ) = 1 THEN
		w_place_template_msg.cb_skip.Visible = False
		w_place_template_msg.cb_skip_temp.Visible = False		
		w_place_template_msg.ddlb_font.Visible = False		
		w_place_template_msg.st_font.Visible = False		
		w_place_template_msg.em_rec.Visible = False				
		w_place_template_msg.st_rec.Visible = False				
		w_place_template_msg.cbx_all.Visible = False				
		w_place_template_msg.st_click.Visible = False			
		w_place_template_msg.cb_yes.Visible = True
		w_place_template_msg.cb_no.Visible = True				
		w_place_template_msg.st_fld.text = "Would you like to place fields for an additional record for the current template?"
		w_place_template_msg.ib_wait_for_click = True
		DO WHILE	w_place_template_msg.ib_wait_for_click 
			Yield()
		LOOP
		w_place_template_msg.ib_wait_for_click = False
		w_place_template_msg.cb_skip.Visible = True
		w_place_template_msg.cb_skip_temp.Visible = True		
		w_place_template_msg.ddlb_font.Visible = True		
		w_place_template_msg.st_font.Visible = True		
		w_place_template_msg.em_rec.Visible = True				
		w_place_template_msg.st_rec.Visible = True				
		w_place_template_msg.cbx_all.Visible = True				
		w_place_template_msg.st_click.Visible = True			
		w_place_template_msg.st_fld.text = ""		
		w_place_template_msg.cb_yes.Visible = False
		w_place_template_msg.cb_no.Visible = False		
		IF w_place_template_msg.ib_additional_rec = False THEN
			w_place_template_msg.ib_additional_rec = False			
			EXIT
		END IF
	ELSE
		li_rec_num = 1
		EXIT
	END IF
	li_rec_num++
	w_place_template_msg.cbx_all.Checked = True				
	w_place_template_msg.em_rec.Text = String( li_rec_num )
LOOP


//w_train_app.of_save_load()





Return 0


end function

public function integer of_place_template1 ();//w_train_app.tab_1.tabpage_design.ole_edit.SetRedraw( False )
Integer li_copy_cnt
Integer li_font
Integer li_rec_num = 1
integer li_null //maha 042406
long li_y
long li_x
Integer i

setnull(li_null)//Start Code Change ---- 04.24.2006 #423 maha
IF w_train_app.ib_skip_temp THEN
	w_train_app.ib_skip_temp = False		
	w_train_app.ib_click_position = True
	of_place_template_end()	
	Return 0
END IF

IF w_train_app.ib_skip = FALSE AND ii_ids_app_prop_i >=1 AND ii_ids_app_prop_i <= ii_ids_app_prop_rc AND w_train_app.ib_placing_template THEN
	il_next_id++
	
	//Start Code Change ---- 12.13.2005 #168 maha	
	li_y = w_train_app.ii_ancor_y -8
	li_x = w_train_app.ii_ancor_x
	li_y = li_y - w_train_app.tab_1.tabpage_design.ole_edit.object.ScrollPositiony( )
	//li_y = li_y - w_train_app.tab_1.tabpage_design.ole_edit.object.ScrollPositionX( ) //evan 05.09.2012
	li_x = li_x - w_train_app.tab_1.tabpage_design.ole_edit.object.ScrollPositionX( )   //evan 05.09.2012
	ids_app_sect.SetItem( ii_ids_app_prop_i, "y_pos",  li_y  )
	ids_app_sect.SetItem( ii_ids_app_prop_i, "x_pos",  li_x )	
	//End Code Change---12.13.2005
	ids_app_sect.SetItem( ii_ids_app_prop_i, "page", w_train_app.ii_current_page )		
	ids_app_sect.SetItem( ii_ids_app_prop_i, "app_id", w_train_app.ii_app_id  )	
	ids_app_sect.SetItem( ii_ids_app_prop_i, "app_field_id", il_next_id )
	//Start Code Change ---- 04.24.2006 #423 maha  clear the connect values
	ids_app_sect.SetItem( ii_ids_app_prop_i, "connect_field_id", li_null )			
	ids_app_sect.SetItem( ii_ids_app_prop_i, "connect_field_sort", li_null )
	//End Code Change---04.24.2006
	CHOOSE CASE w_place_template_msg.ddlb_font.Text 	
		CASE "Small"
			li_font = 1
		CASE "Medium"	
			li_font = 2
		CASE "Large"		
			li_font = 3
	END CHOOSE
	ids_app_sect.SetItem( ii_ids_app_prop_i, "font_size", li_font )	
	ids_app_sect.SetItem( ii_ids_app_prop_i, "record_number", Integer( w_place_template_msg.em_rec.Text ) )		
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Evan 04.07.2009
	//$<reason> New feature for App Mapping Addition Filters.
	//          PB rowscopy function have a bug.
	/*
	//Start Code Change ---- 12.05.2005 #160 maha	
	integer res
	res = ids_app_sect.RowsCopy( ii_ids_app_prop_i, ii_ids_app_prop_i, Primary!, ids_app_prop, 1, Primary!)
	if res = -1 then
		messagebox("Rowscopy error in of_place_template of w_section_templates", "Contact IntelliSoft Group support.")
		of_place_template_end()
		RETURN -1
	end if
	//End Code Change---12.05.2005
	*/
	ids_app_prop.InsertRow(0)
	ids_app_prop.object.data[ids_app_prop.RowCount()] = ids_app_sect.object.data[ii_ids_app_prop_i]
	//------------------- APPEON END ---------------------
	
	ids_app_prop.Update( )
	
	COMMIT USING w_train_app.tr_training_data;
	
	w_train_app.ib_loading_annotations = False
	w_train_app.of_create_annotations( il_next_id )
	w_train_app.ib_loading_annotations = False
END IF

w_train_app.ib_skip = False
ii_ids_app_prop_i++

IF ii_ids_app_prop_i <= ii_ids_app_prop_rc THEN
	w_train_app.ib_click_position = True
	w_place_template_msg.st_fld.Text = ids_app_sect.GetItemSTring( ii_ids_app_prop_i, "field_description" )
	
	IF NOT w_place_template_msg.cbx_all.Checked THEN
		w_place_template_msg.ddlb_font.SelectItem(  ids_app_sect.GetItemNumber( ii_ids_app_prop_i, "font_size" ) )
		w_place_template_msg.em_rec.Text = String( ids_app_sect.GetItemNumber( ii_ids_app_prop_i, "record_number" ) )	
	END IF
ELSE
	ids_app_prop.SetSort( "x_pos A, y_pos A" )
	ids_app_prop.Sort()
	ii_ids_app_prop_rc = ids_app_prop.RowCount( )
	FOR i = 1 TO ii_ids_app_prop_rc
		w_train_app.is_selected_fields[ i ] = String( ids_app_prop.GetItemNumber( i, "app_field_id" ) )
	END FOR

	w_train_app.ib_placing_template = False
	w_place_template_msg.ib_wait_for_click = True
	of_place_template2()
END IF

RETURN 0
end function

public function integer of_place_template_end ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.16.2006 By: LeiWei
//$<reason> Fix a defect.
IF ii_place_mode = 1 THEN
	w_train_app.ib_placing_template = FALSE

	IF IsValid( w_place_template_msg ) THEN
		Close( w_place_template_msg )
	END IF
	
	if isvalid(m_pfe_train_app) then 
		m_pfe_train_app.m_tools.m_selectfield.TriggerEvent( Clicked! )
	end if 
	
	IF IsValid( w_section_templates ) THEN
		This.Visible = True
		Close( w_section_templates )
	END IF

	RETURN 0
ELSEIF ii_place_mode = 2 THEN
	Integer li_template_cnt
	Integer li_template_id
	String ls_template_name
	Long li_dummy[]
	String ls_dummy[]

	ii_dw_templates_i ++
	li_template_cnt = dw_templates.Rowcount( )
	
	IF ii_dw_templates_i <= li_template_cnt THEN
		w_train_app.ii_align = 0
		w_train_app.ii_ancor_count = 0
		w_train_app.is_selected_fields = ls_dummy
		w_train_app.ii_x = li_dummy
		w_train_app.ii_y = li_dummy
		w_train_app.ii_copy_fields = 0
		w_train_app.ii_shift_down_count = 0
	
		li_template_id = dw_templates.GetItemNumber( ii_dw_templates_i, "template_id" )
		ls_template_name = dw_templates.GetItemString( ii_dw_templates_i, "template_name" )
		w_place_template_msg.st_template.Text = ls_template_name + " Template  -  " + String( ii_dw_templates_i ) + " of " + String( li_template_cnt )
		w_train_app.ib_placing_template = True
		w_train_app.ib_click_position = True
		w_train_app.tab_1.tabpage_design.ole_edit.SetFocus()
		dw_templates.SetRow( ii_dw_templates_i )
		
		w_train_app.ib_placing_template = TRUE
		of_place_template()
		RETURN 0
	END IF
	
	w_train_app.ib_placing_template = FALSE

	dw_templates.SetFilter( "" )
	dw_templates.Filter( )
	
	m_pfe_train_app.m_tools.m_selectfield.TriggerEvent( Clicked! )
	
	Close( w_place_template_msg )
	
	This.Visible = True
	
	Close( This )
END IF

RETURN 0
//---------------------------- APPEON END ----------------------------

end function

public function integer of_place_template2 ();Integer li_copy_cnt
Integer li_font
Long li_next_id
Integer li_rc
long li_y
long li_x
	
IF dw_templates.GetItemNumber( dw_templates.GetRow(), "multi_record" ) = 1 THEN
	IF NOT w_place_template_msg.ib_wait_for_click THEN
		w_place_template_msg.cb_pause.Visible = True		
		w_place_template_msg.cb_skip.Visible = True
		w_place_template_msg.cb_skip_temp.Visible = True		
		w_place_template_msg.ddlb_font.Visible = True		
		w_place_template_msg.st_font.Visible = True		
		w_place_template_msg.em_rec.Visible = True				
		w_place_template_msg.st_rec.Visible = True				
		w_place_template_msg.cbx_all.Visible = True				
		w_place_template_msg.st_click.Visible = True			
		w_place_template_msg.st_fld.text = ""		
		w_place_template_msg.cb_yes.Visible = False
		w_place_template_msg.cb_no.Visible = False		
		IF w_place_template_msg.ib_additional_rec = False THEN
			w_place_template_msg.ib_additional_rec = False			
			of_place_template_end()
			RETURN 0
		END IF

		ii_rec_num++
		w_place_template_msg.cbx_all.Checked = True				
		w_place_template_msg.em_rec.Text = String( ii_rec_num )	
		w_train_app.of_copy_fields()
	END IF
	
	w_place_template_msg.cb_skip.Visible = False
	w_place_template_msg.cb_pause.Visible = False
	w_place_template_msg.cb_skip_temp.Visible = False		
	w_place_template_msg.ddlb_font.Visible = False		
	w_place_template_msg.st_font.Visible = False		
	w_place_template_msg.em_rec.Visible = False				
	w_place_template_msg.st_rec.Visible = False				
	w_place_template_msg.cbx_all.Visible = False				
	w_place_template_msg.st_click.Visible = False			
	w_place_template_msg.cb_yes.Visible = True
	w_place_template_msg.cb_no.Visible = True				
	w_place_template_msg.ib_wait_for_click = True
	w_place_template_msg.st_fld.text = "Would you like to place fields for an additional record for the current template?"		
ELSE
	ii_rec_num = 1
	of_place_template_end()
	RETURN 0
END IF

Return 0

end function

on w_templates_v9.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_new1=create st_new1
this.st_new3=create st_new3
this.cb_new=create cb_new
this.cb_save=create cb_save
this.cb_apply=create cb_apply
this.dw_templates=create dw_templates
this.sle_saveas=create sle_saveas
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.gb_1=create gb_1
this.dw_temp_flds=create dw_temp_flds
this.cb_del_field=create cb_del_field
this.cb_2=create cb_2
this.cb_interview=create cb_interview
this.gb_place=create gb_place
this.st_new2=create st_new2
this.dw_order=create dw_order
this.gb_2=create gb_2
this.gb_hide=create gb_hide
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.st_new1
this.Control[iCurrent+4]=this.st_new3
this.Control[iCurrent+5]=this.cb_new
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_apply
this.Control[iCurrent+8]=this.dw_templates
this.Control[iCurrent+9]=this.sle_saveas
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.cb_delete
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.dw_temp_flds
this.Control[iCurrent+15]=this.cb_del_field
this.Control[iCurrent+16]=this.cb_2
this.Control[iCurrent+17]=this.cb_interview
this.Control[iCurrent+18]=this.gb_place
this.Control[iCurrent+19]=this.st_new2
this.Control[iCurrent+20]=this.dw_order
this.Control[iCurrent+21]=this.gb_2
this.Control[iCurrent+22]=this.gb_hide
end on

on w_templates_v9.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_new1)
destroy(this.st_new3)
destroy(this.cb_new)
destroy(this.cb_save)
destroy(this.cb_apply)
destroy(this.dw_templates)
destroy(this.sle_saveas)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.gb_1)
destroy(this.dw_temp_flds)
destroy(this.cb_del_field)
destroy(this.cb_2)
destroy(this.cb_interview)
destroy(this.gb_place)
destroy(this.st_new2)
destroy(this.dw_order)
destroy(this.gb_2)
destroy(this.gb_hide)
end on

event open;call super::open;dw_templates.SetTransObject( w_train_app.tr_training_data )
dw_templates.Retrieve( )




end event

event close;
Return
end event

event closequery;Return 
end event

type rb_2 from radiobutton within w_templates_v9
integer x = 594
integer y = 56
integer width = 471
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Place existing"
end type

event clicked;gb_hide.bringtotop = true
parent.height = 2800
end event

type rb_1 from radiobutton within w_templates_v9
integer x = 114
integer y = 56
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "New Template"
end type

event clicked;
//st_new1.visible = true
//st_new2.visible = true
//st_new3.visible = true
parent.height = 700
//IF This.Checked THEN
	sle_saveas.Enabled = True
	cb_save.Enabled = True
	cb_apply.Enabled = False
	cb_delete.Enabled = False
	//cb_close.Enabled = False
	sle_saveas.setfocus() //maha 021506
	gb_hide.bringtotop = false
//ELSE
//	sle_saveas.Enabled = False
//	cb_save.Enabled = False	
//	cb_apply.Enabled = True
//	cb_delete.Enabled = True
//	cb_close.Enabled = True	
//END IF

String ls_dummy[]
long li_dummy[]
w_train_app.ii_ancor_count = 0
w_train_app.is_selected_fields = ls_dummy
w_train_app.ii_app_field_ids = li_dummy
w_train_app.ii_copy_fields = 1	
w_train_app.tab_1.tabpage_design.ole_edit.object.SelectAnnotationGroup( "" )
end event

type st_new1 from statictext within w_templates_v9
integer x = 50
integer y = 232
integer width = 823
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "1) Click New; Enter Template name."
boolean focusrectangle = false
end type

type st_new3 from statictext within w_templates_v9
integer x = 50
integer y = 512
integer width = 603
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "3) Click Save Template."
boolean focusrectangle = false
end type

type cb_new from commandbutton within w_templates_v9
boolean visible = false
integer x = 873
integer y = 208
integer width = 233
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "New"
end type

event clicked;
//st_new1.visible = true
//st_new2.visible = true
//st_new3.visible = true
parent.height = 670
//IF This.Checked THEN
	sle_saveas.Enabled = True
	cb_save.Enabled = True
	cb_apply.Enabled = False
	cb_delete.Enabled = False
	//cb_close.Enabled = False
	sle_saveas.setfocus() //maha 021506
//ELSE
//	sle_saveas.Enabled = False
//	cb_save.Enabled = False	
//	cb_apply.Enabled = True
//	cb_delete.Enabled = True
//	cb_close.Enabled = True	
//END IF

String ls_dummy[]
long li_dummy[]
w_train_app.ii_ancor_count = 0
w_train_app.is_selected_fields = ls_dummy
w_train_app.ii_app_field_ids = li_dummy
w_train_app.ii_copy_fields = 1	
w_train_app.tab_1.tabpage_design.ole_edit.object.SelectAnnotationGroup( "" )
end event

type cb_save from commandbutton within w_templates_v9
integer x = 1106
integer y = 208
integer width = 389
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Save Template"
end type

event clicked;Integer li_loop
Integer li_ancor_x
Integer li_x
Integer li_y
Integer li_rc
Integer li_cnt
Integer i
Integer li_nr
Integer li_template_id
Integer li_ancor_y
integer res
String ls_name
String ls_dummy[]
n_ds lds_app_prop
n_ds lds_app_sect
//debugbreak()
IF sle_saveas.Text = "" OR IsNull( sle_saveas.Text ) THEN
	MessageBox("Save As", "You must first give the template a name." )
	sle_saveas.SetFocus()
	Return
END IF

lds_app_prop = CREATE n_ds
lds_app_sect = CREATE n_ds

lds_app_sect.DataObject = "d_app_field_properties_section_template"
lds_app_sect.SetTransObject( w_train_app.tr_training_data )


lds_app_prop.DataObject = "d_app_field_properties_forpt"
lds_app_prop.SetTransObject( w_train_app.tr_training_data )

li_nr = dw_templates.InsertRow( 0 )

gnv_appeondb.of_startqueue( )

SELECT Max( template_id )  
INTO :li_template_id  
FROM app_sect_temp
USING w_train_app.tr_training_data;

li_cnt = UpperBound( w_train_app.ii_app_field_ids )

FOR i = 1 TO li_cnt
	IF w_train_app.ii_app_field_ids[ i ] <> 0 THEN
		lds_app_prop.Retrieve( w_train_app.ii_app_field_ids[ ] )
		EXIT
	END IF
END FOR

gnv_appeondb.of_commitqueue( )

IF IsNull( li_template_id ) OR li_template_id = 0 THEN
	li_template_id = 1 
ELSE
	li_template_id ++
END IF
//---------------------------- APPEON END ----------------------------

dw_templates.SetItem( li_nr, "template_id", li_template_id )
dw_templates.SetItem( li_nr, "template_name", sle_saveas.Text )

w_train_app.ii_ancor_count = 0
w_train_app.is_selected_fields = ls_dummy
w_train_app.ii_copy_fields = 1	

li_loop = 0

FOR i = 1 TO li_cnt
	IF w_train_app.ii_app_field_ids[ i ] = 0 THEN
		CONTINUE
	END IF
	debugbreak()

	lds_app_prop.SetFilter("app_field_id = " + String(w_train_app.ii_app_field_ids[ i ]) )
	lds_app_prop.Filter( )
	li_rc = lds_app_prop.Rowcount( )
	//---------------------------- APPEON END ----------------------------
	
	li_loop++
	IF li_loop = 1 THEN
		li_ancor_y = lds_app_prop.GetItemNumber( 1, "y_pos" )
		li_ancor_x = lds_app_prop.GetItemNumber( 1, "x_pos" )
	END IF
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Evan 04.08.2009
	//$<reason> New feature for App Mapping Addition Filters.
	//          PB rowscopy function have a bug.
	//res = lds_app_prop.RowsCopy( 1, 1, Primary!, lds_app_sect, 1, Primary!)
	lds_app_sect.InsertRow(1)
	lds_app_sect.object.data[1] = lds_app_prop.object.data[1]
	//------------------- APPEON END ---------------------
	
	li_y = lds_app_sect.GetItemNumber( 1, "y_pos" )
	li_x = lds_app_sect.GetItemNumber( 1, "x_pos" )
	lds_app_sect.SetItem( 1, "y_pos", li_loop )
	lds_app_sect.SetItem( 1, "record_number", 1 )	
	lds_app_sect.SetItem( 1, "x_pos", li_x - li_ancor_x )	
	lds_app_sect.SetItem( 1, "app_id", li_template_id )	
END FOR


gnv_appeondb.of_startqueue( )

dw_templates.update()
res = lds_app_sect.Update( )
if res < 1 then
	messagebox("Template Failed.  Unable to save Template fields.","This error is caused by mapped fields being used in more than one template.  You can either create the template from another set of fields, or contact ISG support to have the Primary Key for the app_sect_temp_field_prop modified to include the app_id.")
end if

ls_name = sle_saveas.Text


COMMIT USING w_train_app.tr_training_data;

sle_saveas.Enabled = False
cb_save.Enabled = False	
cb_apply.Enabled = True
cb_delete.Enabled = True
cb_close.Enabled = True	
//cbx_select.Checked = False

sle_saveas.Text = ""
dw_templates.SetRow( li_nr )
dw_templates.SelectRow( 0, False )
dw_templates.SelectRow( li_nr, True )
dw_templates.ScrollToRow( li_nr )

dw_temp_flds.Retrieve( li_template_id )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

w_train_app.of_select_field( )

//Start Code Change ----04.28.2008 #V8 maha
parent.height = 2800 
//gb_place.visible = true
//gb_place.bringtotop = false
//End Code Change---04.28.2008

//CloseWithReturn( Parent, li_template_id )


end event

type cb_apply from commandbutton within w_templates_v9
integer x = 1509
integer y = 1596
integer width = 407
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Place Template"
end type

event clicked;Integer li_template_id
Long li_dummy[]
String ls_dummy[]

w_train_app.ii_align = 0
w_train_app.ii_ancor_count = 0
w_train_app.is_selected_fields = ls_dummy
w_train_app.ii_x = li_dummy
w_train_app.ii_y = li_dummy
w_train_app.ii_copy_fields = 0
w_train_app.ii_shift_down_count = 0

li_template_id = dw_templates.GetItemNumber( dw_templates.GetRow(), "template_id" )

Open( w_place_template_msg )

Parent.Visible = False

w_train_app.ib_placing_template = True
w_train_app.ib_click_position = True

w_train_app.tab_1.tabpage_design.ole_edit.SetFocus()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.16.2006 By: LeiWei
//$<reason> Fix a defect.
ii_place_mode = 1
//---------------------------- APPEON END ----------------------------

of_place_template()

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 08.16.2006 By: LeiWei
//$<reason> Fix a defect.
//$<modification> The following scripts moved to of_place_tmplate_end().
/*
Close( w_place_template_msg )
if isvalid(m_pfe_train_app) then 
	m_pfe_train_app.m_tools.m_selectfield.TriggerEvent( Clicked! )
end if 



IF IsValid( w_section_templates ) THEN
	This.Visible = True
	Close( Parent )
ELSE
	Return
END IF
//CloseWithReturn( w_section_templates, li_template_id )
*/
//---------------------------- APPEON END ----------------------------

end event

type dw_templates from u_dw within w_templates_v9
integer x = 46
integer y = 700
integer width = 1865
integer height = 884
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Template List"
string dataobject = "d_app_sect_templates"
boolean hscrollbar = true
end type

event clicked;call super::clicked;String ls_field

IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
ELSE
	ls_field = dwo.Name
	IF RightA( ls_field, 2 ) = "_t" THEN
		This.SetSort( MidA( ls_field, 1, LenA( ls_field )-2))
		This.Sort( )
	END IF
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow > 0 THEN
	dw_temp_flds.Retrieve( This.GetItemNumber( currentrow, "template_id" ) )
END IF
end event

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
	dw_temp_flds.Retrieve( This.GetItemNumber( 1, "template_id" ) )
	This.SelectRow( 1, True )
END IF
end event

event doubleclicked;call super::doubleclicked;cb_apply.TriggerEvent( Clicked! )
end event

type sle_saveas from singlelineedit within w_templates_v9
integer x = 562
integer y = 308
integer width = 1335
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_templates_v9
integer x = 50
integer y = 320
integer width = 507
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
string text = "New Template name:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_templates_v9
integer x = 1536
integer y = 40
integer width = 370
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close( Parent )
end event

type cb_delete from commandbutton within w_templates_v9
integer x = 1495
integer y = 208
integer width = 411
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Template"
end type

event clicked;Integer li_ans
Integer li_template_id

li_ans = MessageBox( "Delete Template", "Are you sure you want to delete the selected template and it's fields?", Question!, YesNo!, 1 )

IF li_ans = 2 THEN
	Return
END IF

li_template_id = dw_templates.GetItemNumber( dw_templates.GetRow(), "template_id" )
dw_templates.DeleteRow( dw_templates.GetRow() )

dw_temp_flds.Reset()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

DELETE FROM app_sect_temp_field_prop  
WHERE app_sect_temp_field_prop.app_id = :li_template_id   ;

dw_templates.Update()

COMMIT USING w_train_app.tr_training_data;

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

IF dw_templates.RowCount() > 0 THEN
	dw_temp_flds.SetRow( 1 )
	dw_temp_flds.SelectRow( 0, False )
	dw_temp_flds.SelectRow( 1, True )
	dw_temp_flds.ScrollToRow( 1 )
END IF


end event

type gb_1 from groupbox within w_templates_v9
integer x = 23
integer y = 152
integer width = 1911
integer height = 452
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Create Template"
end type

type dw_temp_flds from u_dw within w_templates_v9
integer x = 50
integer y = 1688
integer width = 1865
integer height = 996
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Template Fields"
string dataobject = "d_app_temp_flds"
end type

event constructor;call super::constructor;dw_temp_flds.SetTransObject( w_train_app.tr_training_data )
end event

event clicked;call super::clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
END IF
end event

type cb_del_field from commandbutton within w_templates_v9
integer x = 727
integer y = 1596
integer width = 370
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Field"
end type

event clicked;Integer li_ans
string s

//Start Code Change ---- 04.11.2006 #392 maha  //trap for no selected row
li_ans = dw_temp_flds.GetRow()
if li_ans < 1 then return
s = dw_temp_flds.GetItemString( li_ans, "field_description" )
//End Code Change---04.11.2006
li_ans = MessageBox( "Delete Field", "Are you sure you want to delete the field : " + s, Question!, YesNo!, 1 )
IF li_ans = 1 THEN
	dw_temp_flds.DeleteRow( 0 )
	dw_temp_flds.Update( )
END IF
end event

type cb_2 from commandbutton within w_templates_v9
integer x = 1143
integer y = 40
integer width = 370
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

dw_templates.Update()
dw_temp_flds.Update()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance. 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

end event

type cb_interview from commandbutton within w_templates_v9
integer x = 1102
integer y = 1596
integer width = 407
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Interview Mode"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.16.2006 By: LeiWei
//$<reason> Fix a defect.
/*
Integer i
Integer li_template_cnt
Integer li_template_id
String ls_template_name
Long li_dummy[]
String ls_dummy[]
Integer li_ans

Open( w_place_template_msg )
Parent.Visible = False

dw_templates.Sort( )
dw_templates.SetFilter( "interview_order <> 999 AND interview_order <> 0 " )
dw_templates.Filter( )
li_template_cnt = dw_templates.RowCount()


FOR i = 1 TO li_template_cnt
	w_train_app.ii_align = 0
	w_train_app.ii_ancor_count = 0
	w_train_app.is_selected_fields = ls_dummy
	w_train_app.ii_x = li_dummy
	w_train_app.ii_y = li_dummy
	w_train_app.ii_copy_fields = 0
	w_train_app.ii_shift_down_count = 0

	li_template_id = dw_templates.GetItemNumber( i, "template_id" )
	ls_template_name = dw_templates.GetItemString( i, "template_name" )
	w_place_template_msg.st_template.Text = ls_template_name + " Template  -  " + String( i ) + " of " + String( li_template_cnt )
	w_train_app.ib_placing_template = True
	w_train_app.ib_click_position = True
	w_train_app.tab_1.tabpage_design.ole_edit.SetFocus()
	dw_templates.SetRow( i )
	of_place_template()
	
END FOR

dw_templates.SetFilter( "" )
dw_templates.Filter( )

m_pfe_train_app.m_tools.m_selectfield.TriggerEvent( Clicked! )

Close( w_place_template_msg )

This.Visible = True

Close( Parent )

//CloseWithReturn( w_section_templates, li_template_id )
*/

Open( w_place_template_msg )
Parent.Visible = False

dw_templates.Sort( )
dw_templates.SetFilter( "interview_order <> 999 AND interview_order <> 0 " )
dw_templates.Filter( )


ii_place_mode = 2
ii_dw_templates_i = 0

of_place_template_end()
//---------------------------- APPEON END ----------------------------

end event

type gb_place from groupbox within w_templates_v9
integer x = 23
integer y = 604
integer width = 1911
integer height = 2112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Place Template"
end type

type st_new2 from statictext within w_templates_v9
integer x = 50
integer y = 420
integer width = 1394
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "2) Select the existing mapped fields for this template."
boolean focusrectangle = false
end type

type dw_order from datawindow within w_templates_v9
boolean visible = false
integer x = 1888
integer y = 1892
integer width = 434
integer height = 380
integer taborder = 120
string dataobject = "d_app_copy_field_order"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_templates_v9
integer x = 23
integer width = 1074
integer height = 140
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Process"
end type

type gb_hide from groupbox within w_templates_v9
integer x = 32
integer y = 156
integer width = 1902
integer height = 444
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
end type

