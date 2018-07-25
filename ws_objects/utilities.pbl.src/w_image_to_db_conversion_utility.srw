$PBExportHeader$w_image_to_db_conversion_utility.srw
forward
global type w_image_to_db_conversion_utility from window
end type
type cb_change from commandbutton within w_image_to_db_conversion_utility
end type
type st_8 from statictext within w_image_to_db_conversion_utility
end type
type st_7 from statictext within w_image_to_db_conversion_utility
end type
type st_count from statictext within w_image_to_db_conversion_utility
end type
type st_6 from statictext within w_image_to_db_conversion_utility
end type
type st_prac from statictext within w_image_to_db_conversion_utility
end type
type st_4 from statictext within w_image_to_db_conversion_utility
end type
type st_pcnt from statictext within w_image_to_db_conversion_utility
end type
type st_3 from statictext within w_image_to_db_conversion_utility
end type
type cb_1 from commandbutton within w_image_to_db_conversion_utility
end type
type st_5 from statictext within w_image_to_db_conversion_utility
end type
type st_exist from statictext within w_image_to_db_conversion_utility
end type
type cb_view4 from commandbutton within w_image_to_db_conversion_utility
end type
type cb_view3 from commandbutton within w_image_to_db_conversion_utility
end type
type cb_view2 from commandbutton within w_image_to_db_conversion_utility
end type
type cb_view1 from commandbutton within w_image_to_db_conversion_utility
end type
type st_good from statictext within w_image_to_db_conversion_utility
end type
type st_match from statictext within w_image_to_db_conversion_utility
end type
type st_file from statictext within w_image_to_db_conversion_utility
end type
type st_up_t from statictext within w_image_to_db_conversion_utility
end type
type st_2 from statictext within w_image_to_db_conversion_utility
end type
type st_1 from statictext within w_image_to_db_conversion_utility
end type
type cb_close from commandbutton within w_image_to_db_conversion_utility
end type
type ole_scan_edit from olecustomcontrol within w_image_to_db_conversion_utility
end type
type ole_admin from olecustomcontrol within w_image_to_db_conversion_utility
end type
type cb_run from commandbutton within w_image_to_db_conversion_utility
end type
type gb_1 from groupbox within w_image_to_db_conversion_utility
end type
end forward

global type w_image_to_db_conversion_utility from window
integer x = 1056
integer y = 484
integer width = 2149
integer height = 1676
boolean titlebar = true
string title = "Migrate Images to database"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_change cb_change
st_8 st_8
st_7 st_7
st_count st_count
st_6 st_6
st_prac st_prac
st_4 st_4
st_pcnt st_pcnt
st_3 st_3
cb_1 cb_1
st_5 st_5
st_exist st_exist
cb_view4 cb_view4
cb_view3 cb_view3
cb_view2 cb_view2
cb_view1 cb_view1
st_good st_good
st_match st_match
st_file st_file
st_up_t st_up_t
st_2 st_2
st_1 st_1
cb_close cb_close
ole_scan_edit ole_scan_edit
ole_admin ole_admin
cb_run cb_run
gb_1 gb_1
end type
global w_image_to_db_conversion_utility w_image_to_db_conversion_utility

type variables
long il_prac_no_file[]
long il_prac_no_match[]
long il_prac_moved[]
long il_prac_exist[]
end variables

forward prototypes
public function integer of_run (string as_type)
end prototypes

public function integer of_run (string as_type);datastore lds_images
datastore lds_pracs
boolean lb_moved
long i
long ic
long p
long pc
long ll_prac
long ll_rec
long ll_seq
long ll_pk
integer li_screen
long fcnt
long mcnt
long gcnt
long ecnt
integer li_start
integer li_num
integer li_total
string ls_path
string ls_file
string ls_savefile,ls_Rtn
pfc_cst_nv_image_functions  lnv_image_functions
blob lb_the_image 

st_file.text = "0"
st_match.text = "0"
st_good.text = "0"
st_exist.text = "0"
st_pcnt.text = "0"

if as_type = "T" then
	st_up_t.text = "Files OK"
else
	st_up_t.text = "Files Updated"
end if


lnv_image_functions = create pfc_cst_nv_image_functions

select imaging_path into :ls_path from ids;
if isnull(ls_path) or LenA(ls_path) < 3 then
	messagebox("Path?","There is no imaging path set")
	return 1
end if

lds_pracs = create datastore
lds_pracs.dataobject = "d_images_distinct_prac"
lds_pracs.settransobject(sqlca)
pc = lds_pracs.retrieve()

st_pcnt.text = string(pc)

lds_images = create datastore
lds_images.dataobject = "d_images_all_pd_data"
lds_images.settransobject(sqlca)
lds_images.retrieve()

for p = 1 to pc
	li_total = 0
	lb_moved = false
	ll_prac = lds_pracs.getitemnumber(p,"prac_id")
	ls_file = ls_path + string(ll_prac) + ".tif"
	st_prac.text = string(ll_prac)
	st_count.text = string(p)
//	messagebox("file",ls_file)
	if not fileexists(ls_file ) then //trap for file
		fcnt++
		il_prac_no_file[fcnt] = ll_prac
		st_file.text = string(fcnt)
		continue 
	end if
	lds_images.setfilter( "prac_id = " + string(ll_prac) )
	lds_images.filter( )
	ic = lds_images.rowcount()
	if ic = 0 then //redundant trap for data
		fcnt++
		continue 
	end if
	
	for i = 1 to ic //trap for page counts
		li_num = lds_images.getitemnumber(i,"num_pages") //Start Code Change ----03.18.2008 #V8 maha - bug correct
		li_total = li_total + li_num
	next
	
	ole_scan_edit.Object.Image( ls_file )
	
	if ole_scan_edit.Object.Pagecount() <> li_total then
		mcnt++
		il_prac_no_match[mcnt] = ll_prac
		st_match.text = string(mcnt)
		continue 
	end if
	
	for i = 1 to ic
		if lds_images.getitemnumber(i,"datalen") > 0 then continue  //trap for existing image data
		
		li_start = lds_images.getitemnumber(i,"tif_start_page")
		li_num = lds_images.getitemnumber(i,"num_pages")
		ll_rec = lds_images.getitemnumber(i,"rec_id")
		ll_pk = lds_images.getitemnumber(i,"image_pk")
		li_screen = lds_images.getitemnumber(i,"screen_id")
		
		ls_savefile = gs_dir_path + "intellicred\"  +string(ll_prac) + "-temp-" + string(i) + ".tif"  //Start Code Change ----02.05.2009 #V92 maha - added intellicred folder to path
		//messagebox("file",ls_savefile)
		if as_type = "R" then
			
			ole_admin.Object.Image( ls_savefile )
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-07-17 By: Scofield
			//$<Reason> Verify if the directory has write right for the current user.
			
			ls_Rtn = f_ExaWriteRight(ls_file)
			if LenA(ls_Rtn) > 0 then
				MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
				CONTINUE
			end if
			//---------------------------- APPEON END ----------------------------
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> Evan 08.31.2009
			//$<reason> The Append method cannot accept null parameter.
			if IsNull(ls_file) or IsNull(li_start) or IsNull(li_num) then
				MessageBox("Prompt", "Failed to append pages to the specified image. The Append method cannot accept null parameter.", Exclamation!)
				continue
			end if
			//---------------------------- APPEON END ----------------------------
			//Start Code Change ----12.9.2009 #V10 maha - added try catch
			Try
				ole_admin.object.Append( ls_file, li_start, li_num  ) //creates file for specific image			
			Catch(OLERuntimeError err)
				Continue
			End Try
			//End Code Change---12.09.2009
			
			
			lb_the_image = lnv_image_functions.of_read_image_file( ls_savefile )
		
			UPDATEBLOB pd_images
			SET image_data = :lb_the_image
			WHERE image_pk = :ll_pk			
			USING SQLCA;
		
			IF SQLCA.SQLNRows > 0 THEN
				COMMIT USING SQLCA ;
				 lds_images.setitem(i,"tif_start_page",1)//Start Code Change ----03.20.2008 #V8 maha - resert the tart page
			ELSEIF SQLCA.SQLCODE = -1 THEN
				MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
			ELSEIF SQLCA.SQLNRows = 0 THEN	
				MessageBox( "SQL Error", "No rows effected." )
			END IF
			
			filedelete(ls_savefile)
		end if
		
		lb_moved = true
	next
	
	if lb_moved then
		gcnt++
		 il_prac_moved[gcnt] = ll_prac
		st_good.text = string(gcnt)
	else
		ecnt++
		 il_prac_exist[ecnt] = ll_prac
		 st_exist.text = string(ecnt)
	end if
	
next

 lds_images.update()  //Start Code Change ----03.20.2008 #V8 maha - save start page changes.
 commit using sqlca;
cb_view1.enabled = true
cb_view2.enabled = true
cb_view3.enabled = true
cb_view4.enabled = true

if as_type = "R" then cb_change.enabled = true //Start Code Change ----04.30.2012 #V12 maha

destroy lnv_image_functions
destroy lds_images
destroy lds_pracs

return 1

end function

on w_image_to_db_conversion_utility.create
this.cb_change=create cb_change
this.st_8=create st_8
this.st_7=create st_7
this.st_count=create st_count
this.st_6=create st_6
this.st_prac=create st_prac
this.st_4=create st_4
this.st_pcnt=create st_pcnt
this.st_3=create st_3
this.cb_1=create cb_1
this.st_5=create st_5
this.st_exist=create st_exist
this.cb_view4=create cb_view4
this.cb_view3=create cb_view3
this.cb_view2=create cb_view2
this.cb_view1=create cb_view1
this.st_good=create st_good
this.st_match=create st_match
this.st_file=create st_file
this.st_up_t=create st_up_t
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.ole_scan_edit=create ole_scan_edit
this.ole_admin=create ole_admin
this.cb_run=create cb_run
this.gb_1=create gb_1
this.Control[]={this.cb_change,&
this.st_8,&
this.st_7,&
this.st_count,&
this.st_6,&
this.st_prac,&
this.st_4,&
this.st_pcnt,&
this.st_3,&
this.cb_1,&
this.st_5,&
this.st_exist,&
this.cb_view4,&
this.cb_view3,&
this.cb_view2,&
this.cb_view1,&
this.st_good,&
this.st_match,&
this.st_file,&
this.st_up_t,&
this.st_2,&
this.st_1,&
this.cb_close,&
this.ole_scan_edit,&
this.ole_admin,&
this.cb_run,&
this.gb_1}
end on

on w_image_to_db_conversion_utility.destroy
destroy(this.cb_change)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_count)
destroy(this.st_6)
destroy(this.st_prac)
destroy(this.st_4)
destroy(this.st_pcnt)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.st_exist)
destroy(this.cb_view4)
destroy(this.cb_view3)
destroy(this.cb_view2)
destroy(this.cb_view1)
destroy(this.st_good)
destroy(this.st_match)
destroy(this.st_file)
destroy(this.st_up_t)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.ole_scan_edit)
destroy(this.ole_admin)
destroy(this.cb_run)
destroy(this.gb_1)
end on

type cb_change from commandbutton within w_image_to_db_conversion_utility
integer x = 430
integer y = 1408
integer width = 1189
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Migration Completed.  Change program setting"
end type

event clicked;//Start Code Change ----04.03.2012 #V12 maha
update icred_settings set image_storage_type = 1;
end event

type st_8 from statictext within w_image_to_db_conversion_utility
integer x = 59
integer y = 160
integer width = 2002
integer height = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Please run TEST before actually running the migration.  If you have any questions please contact IntelliSoft Group support at support@intellisoftgroup.com"
boolean focusrectangle = false
end type

type st_7 from statictext within w_image_to_db_conversion_utility
integer x = 59
integer y = 412
integer width = 2002
integer height = 156
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "If the data is out of sync with the images, the data would migrate improperly and have to be manually corrected, so these images cannot be migrated until corrected."
boolean focusrectangle = false
end type

type st_count from statictext within w_image_to_db_conversion_utility
integer x = 553
integer y = 660
integer width = 334
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
alignment alignment = right!
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_image_to_db_conversion_utility
integer x = 1015
integer y = 676
integer width = 233
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Prac_id:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_prac from statictext within w_image_to_db_conversion_utility
integer x = 1257
integer y = 668
integer width = 329
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
alignment alignment = right!
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_image_to_db_conversion_utility
integer x = 59
integer y = 288
integer width = 2002
integer height = 124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Note: When testing page counts, this utility tests totals.  If the page counts match, the images will be migrated."
boolean focusrectangle = false
end type

type st_pcnt from statictext within w_image_to_db_conversion_utility
integer x = 1129
integer y = 792
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type st_3 from statictext within w_image_to_db_conversion_utility
integer x = 457
integer y = 792
integer width = 626
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Providers with Image data:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_image_to_db_conversion_utility
integer x = 82
integer y = 36
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test"
end type

event clicked;of_run("T")
end event

type st_5 from statictext within w_image_to_db_conversion_utility
integer x = 549
integer y = 1204
integer width = 535
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Images existing in DB:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_exist from statictext within w_image_to_db_conversion_utility
integer x = 1129
integer y = 1204
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type cb_view4 from commandbutton within w_image_to_db_conversion_utility
integer x = 1353
integer y = 1188
integer width = 201
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "View"
end type

event clicked;gs_variable_array  lst_pass

lst_pass.as_string[1] = "Practitioners where Image data already existed in the DB."
lst_pass.as_number[] =  il_prac_exist[]

openwithparm(w_image_migrate_view_results,lst_pass)

//
end event

type cb_view3 from commandbutton within w_image_to_db_conversion_utility
integer x = 1353
integer y = 1088
integer width = 201
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "View"
end type

event clicked;gs_variable_array  lst_pass

lst_pass.as_string[1] = "Practitioners where Image data migrated ok."
lst_pass.as_number[] =  il_prac_moved[]

openwithparm(w_image_migrate_view_results,lst_pass)

//
end event

type cb_view2 from commandbutton within w_image_to_db_conversion_utility
integer x = 1353
integer y = 980
integer width = 201
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "View"
end type

event clicked;gs_variable_array  lst_pass

lst_pass.as_string[1] = "Practitioners where Image data page Counts do not match the # of Pages in the  file."
lst_pass.as_number[] = il_prac_no_match[]

openwithparm(w_image_migrate_view_results,lst_pass)
end event

type cb_view1 from commandbutton within w_image_to_db_conversion_utility
integer x = 1353
integer y = 872
integer width = 201
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "View"
end type

event clicked;gs_variable_array  lst_pass

lst_pass.as_string[1] = "Practitioners with Image data but no Image file."
lst_pass.as_number[] = il_prac_no_file[]

openwithparm(w_image_migrate_view_results,lst_pass)
end event

type st_good from statictext within w_image_to_db_conversion_utility
integer x = 1129
integer y = 1104
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type st_match from statictext within w_image_to_db_conversion_utility
integer x = 1129
integer y = 1000
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type st_file from statictext within w_image_to_db_conversion_utility
integer x = 1129
integer y = 892
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type st_up_t from statictext within w_image_to_db_conversion_utility
integer x = 741
integer y = 1104
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Files updated:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_image_to_db_conversion_utility
integer x = 521
integer y = 1000
integer width = 562
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Page counts not match:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_image_to_db_conversion_utility
integer x = 640
integer y = 892
integer width = 443
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "File does not exist:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_image_to_db_conversion_utility
integer x = 1733
integer y = 36
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(parent)

end event

type ole_scan_edit from olecustomcontrol within w_image_to_db_conversion_utility
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
integer x = 2290
integer y = 192
integer width = 101
integer height = 100
integer taborder = 10
long backcolor = 67108864
boolean focusrectangle = false
string binarykey = "w_image_to_db_conversion_utility.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_admin from olecustomcontrol within w_image_to_db_conversion_utility
event filepropertiesclose ( )
integer x = 2249
integer y = 44
integer width = 155
integer height = 136
integer taborder = 10
borderstyle borderstyle = stylelowered!
string binarykey = "w_image_to_db_conversion_utility.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_run from commandbutton within w_image_to_db_conversion_utility
integer x = 434
integer y = 36
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;of_run("R")

//datastore lds_images
//datastore lds_pracs
//boolean lb_moved
//long i
//long ic
//long p
//long pc
//long ll_prac
//long ll_rec
//long ll_seq
//integer li_screen
//long fcnt
//long mcnt
//long gcnt
//long ecnt
//integer li_start
//integer li_num
//integer li_total
//string ls_path
//string ls_file
//string ls_savefile
//pfc_cst_nv_image_functions  lnv_image_functions
//blob lb_the_image 
//
//
//lnv_image_functions = create pfc_cst_nv_image_functions
//
//select imaging_path into :ls_path from ids;
//if isnull(ls_path) or len(ls_path) < 3 then
//	messagebox("Path?","There is no imaging path set")
//	return
//end if
//
//lds_pracs = create datastore
//lds_pracs.dataobject = "d_images_distinct_prac"
//lds_pracs.settransobject(sqlca)
//pc = lds_pracs.retrieve()
//
//lds_images = create datastore
//lds_images.dataobject = "d_images_all_pd_data"
//lds_images.settransobject(sqlca)
//lds_images.retrieve()
//
//for p = 1 to pc
//	li_total = 0
//	lb_moved = false
//	ll_prac = lds_pracs.getitemnumber(p,"prac_id")
//	ls_file = ls_path + string(ll_prac) + ".tif"
////	messagebox("file",ls_file)
//	if not fileexists(ls_file ) then //trap for file
//		fcnt++
//		il_prac_no_file[fcnt] = ll_prac
//		st_file.text = string(fcnt)
//		continue 
//	end if
//	lds_images.setfilter( "prac_id = " + string(ll_prac) )
//	lds_images.filter( )
//	ic = lds_images.rowcount()
//	if ic = 0 then //redundant trap for data
//		fcnt++
//		continue 
//	end if
//	
//	for i = 1 to ic //trap for page counts
//		li_num = lds_images.getitemnumber(i,"num_pages") //Start Code Change ----03.18.2008 #V8 maha - bug correct
//		li_total = li_total + li_num
//	next
//	
//	ole_scan_edit.Object.Image( ls_file )
//	
//	if ole_scan_edit.Object.Pagecount() <> li_total then
//		mcnt++
//		il_prac_no_match[mcnt] = ll_prac
//		st_match.text = string(mcnt)
//		continue 
//	end if
//	
//	for i = 1 to ic
//		if lds_images.getitemnumber(i,"datalen") > 0 then continue  //trap for existing image data
//		
//		li_start = lds_images.getitemnumber(i,"tif_start_page")
//		li_num = lds_images.getitemnumber(i,"num_pages")
//		ll_rec = lds_images.getitemnumber(i,"rec_id")
//		ll_seq = lds_images.getitemnumber(i,"seq_no")
//		li_screen = lds_images.getitemnumber(i,"screen_id")
//		
//		ls_savefile = gs_dir_path + string(ll_prac) + "-temp-" + string(i) + ".tif"
//		//messagebox("file",ls_savefile)
//		
//		ole_admin.Object.Image( ls_savefile )
//		
//		ole_admin.object.Append( ls_file, li_start, li_num  ) //creates file for specific image
//		
//		lb_the_image = lnv_image_functions.of_read_image_file( ls_savefile )
//	
//		UPDATEBLOB pd_images
//		SET image_data = :lb_the_image
//		WHERE rec_id = :ll_rec and
//	   	   prac_id = :ll_prac and
//				seq_no = :ll_seq and
//				screen_id = :li_screen			
//		USING SQLCA;
//	
//		IF SQLCA.SQLNRows > 0 THEN
//			COMMIT USING SQLCA ;
//		ELSEIF SQLCA.SQLCODE = -1 THEN
//			MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
//		ELSEIF SQLCA.SQLNRows = 0 THEN	
//			MessageBox( "SQL Error", "No rows effected." )
//		END IF
//		
//		filedelete(ls_savefile)
//		
//		lb_moved = true
//	next
//	
//	if lb_moved then
//		gcnt++
//		 il_prac_moved[gcnt] = ll_prac
//		st_good.text = string(gcnt)
//	else
//		ecnt++
//		 il_prac_exist[ecnt] = ll_prac
//		 st_exist.text = string(ecnt)
//	end if
//	
//next
//
//cb_view1.enabled = true
//cb_view2.enabled = true
//cb_view3.enabled = true
//cb_view4.enabled = true
//
//destroy lnv_image_functions
//destroy lds_images
//destroy lds_pracs
//
//
end event

type gb_1 from groupbox within w_image_to_db_conversion_utility
integer x = 46
integer y = 568
integer width = 2034
integer height = 780
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Results"
borderstyle borderstyle = stylebox!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fw_image_to_db_conversion_utility.bin 
2800000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000048eb44001d175d500000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000048eb44001d175d5048eb44001d175d5000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
29ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc000000030002000500000003000002460000000300000295000000030000006000000002000000010000001e0000000945676d493174696400000000000000031ff1fdff0000000b0000ffff000000020000bb2c000000020000bb2c000000030012bb7c000000030012bb7c0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500000246000002950000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000ff000000001ff1fd00000000ee000100bbc000001000bbc0100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000048eb44001d175d500000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000048eb44001d175d5048eb44001d175d5000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000300020000038400000384000000000000010000000000000000000000000001010000000000000000000000000000010003000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001000000000200000300000000000300000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fw_image_to_db_conversion_utility.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
