$PBExportHeader$w_recruitment_data_search.srw
forward
global type w_recruitment_data_search from w_response
end type
type rb_6 from radiobutton within w_recruitment_data_search
end type
type rb_5 from radiobutton within w_recruitment_data_search
end type
type rb_4 from radiobutton within w_recruitment_data_search
end type
type rb_3 from radiobutton within w_recruitment_data_search
end type
type rb_2 from radiobutton within w_recruitment_data_search
end type
type rb_1 from radiobutton within w_recruitment_data_search
end type
type dw_3 from u_dw within w_recruitment_data_search
end type
type ddlb_1 from dropdownlistbox within w_recruitment_data_search
end type
type sle_1 from singlelineedit within w_recruitment_data_search
end type
type cb_4 from commandbutton within w_recruitment_data_search
end type
type dw_2 from datawindow within w_recruitment_data_search
end type
type dw_1 from datawindow within w_recruitment_data_search
end type
type cb_upload from commandbutton within w_recruitment_data_search
end type
type cb_email from commandbutton within w_recruitment_data_search
end type
type cb_convert from commandbutton within w_recruitment_data_search
end type
type cb_delete from commandbutton within w_recruitment_data_search
end type
type cb_save from commandbutton within w_recruitment_data_search
end type
type cb_add from commandbutton within w_recruitment_data_search
end type
type cb_close from commandbutton within w_recruitment_data_search
end type
type dw_browse from u_dw within w_recruitment_data_search
end type
type dw_detail from u_dw within w_recruitment_data_search
end type
type cb_view from commandbutton within w_recruitment_data_search
end type
type ddlb_filter from dropdownlistbox within w_recruitment_data_search
end type
type st_1 from statictext within w_recruitment_data_search
end type
type gb_2 from groupbox within w_recruitment_data_search
end type
type gb_3 from groupbox within w_recruitment_data_search
end type
type gb_4 from groupbox within w_recruitment_data_search
end type
type gb_1 from groupbox within w_recruitment_data_search
end type
end forward

global type w_recruitment_data_search from w_response
integer width = 4187
integer height = 2648
string title = "Recruitment Applications"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
dw_3 dw_3
ddlb_1 ddlb_1
sle_1 sle_1
cb_4 cb_4
dw_2 dw_2
dw_1 dw_1
cb_upload cb_upload
cb_email cb_email
cb_convert cb_convert
cb_delete cb_delete
cb_save cb_save
cb_add cb_add
cb_close cb_close
dw_browse dw_browse
dw_detail dw_detail
cb_view cb_view
ddlb_filter ddlb_filter
st_1 st_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_1 gb_1
end type
global w_recruitment_data_search w_recruitment_data_search

type variables
long il_loc_id = 1
string is_filter
end variables

forward prototypes
public function integer of_filter_status ()
public function integer of_expandnotes (long al_row, string as_column)
public function integer of_download_image (long al_prac_id)
public function integer of_modify_fieldprop ()
public function long of_getpracid ()
public function long of_triggerrowfocuschanged (long al_row)
public function integer of_refresh_browse (long al_loc_id)
public function integer of_save ()
end prototypes

public function integer of_filter_status ();long ll_row

ll_row = dw_browse.getrow( )

dw_browse.setfilter(is_filter)
dw_browse.filter()

of_triggerRowfocuschanged(ll_row)


return 1
end function

public function integer of_expandnotes (long al_row, string as_column);//====================================================================
//$<Function>: of_expandnotes
//$<Arguments>:
// 	value    long      al_row
// 	value    string    as_column
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.05.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_text

ls_text = dw_detail.getitemstring( al_row,as_column)
	if isnull(ls_text) then ls_text = ""  //(Appeon)Harry 07.16.2014 - for the Bug 4115
	openWithParm(w_ai_notes_new,ls_text)
	
	if Message.stringparm = 'Cancel' then 
			return -1
	else
			ls_text = Message.stringparm
			//dw_detail.setitem( al_row,as_column,ls_text)
			if lower(as_column) <>	'addtl_comments' then dw_detail.setitem( al_row,as_column,ls_text)//long.zhang  Testing Bug # 3960
	end if
	
return 1
end function

public function integer of_download_image (long al_prac_id);//====================================================================
//$<Function>: of_download_image
//$<Arguments>:
// 	value    long    al_prac_id
//$<Return>:  integer
//$<Description>: Download CV From recruit image table
//$<Author>: (Appeon) long.zhang 09.06.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_start_page
Integer li_num_pages
Long li_filenum
Long ll_filelen
Long ll_start
Long ll_new_pos, ll_data_length
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob total_blob

string ls_file

SetPointer(HourGlass!)

String ls_filename, ls_Null, ls_filetype

SELECT file_name, file_type
	INTO :ls_filename, :ls_filetype
	FROM recruit_image
	WHERE prac_id = :al_prac_id
	USING SQLCA;
	
if sqlca.sqlcode=100 or isnull(ls_filename) then
	messagebox("Prompt","There is no CV uploaded!")
	return -1
elseif sqlca.sqlcode < 0 then
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
end if	


ls_file = gs_temp_path + "images\"  
gnv_appeondll.of_parsepath(ls_file)



	ll_start = LastPos(ls_filename,'\')
	ls_filename = MidA(ls_filename,ll_start+1)


if pos(ls_filename,'\') > 0 then
	ls_file = ls_file + mid(ls_filename, pos(ls_filename,'\') +1)
else
	ls_file = ls_file +ls_filename
end if

IF FileExists(ls_file) THEN
	filedelete(ls_file)
END IF

openwithparm( w_appeon_gifofwait, "Downloading CV from Database..." )

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	
	SELECT Datalength(image_field)
	INTO :ll_data_length
	FROM recruit_image
	WHERE prac_id  = :al_prac_id
	USING SQLCA;
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		messagebox("Prompt","There is no CV uploaded!")
		RETURN 0
	END IF
	
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 
	
	FOR li_counter = 1 to li_loops
		Yield()
		SetPointer(HourGlass!)
		
		ll_start = (li_counter - 1) * 8000 + 1
		SELECTBLOB substring(image_field,:ll_start,8000)
		     INTO :blob_temp
		    FROM recruit_image
	      WHERE prac_id  = :al_prac_id
	       USING  SQLCA;
	
		total_blob += blob_temp
	NEXT 
	
	lb_image_data = total_blob

ELSE
	
	SELECTBLOB image_field 
	INTO :lb_image_data
	FROM recruit_image 
	WHERE prac_id  = :al_prac_id
	USING SQLCA;
	
END IF


IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1

IF Not FileExists( ls_file) THEN 
	MessageBox("File Creation Error", "No  file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
END IF

setnull(ls_Null)
IF FileExists(ls_file) THEN
	ShellExecuteA ( Handle( This ), "open", ls_file, ls_Null, ls_Null, 1)
END IF
	
Return 1

end function

public function integer of_modify_fieldprop ();//====================================================================
//$<Function>: of_set_require_field
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
datastore lds_field_prop
long ll_rowcount
Integer ll_i
String ls_field_name
String ls_text
String ls_sqlselect
Integer li_visible

lds_field_prop = create datastore
lds_field_prop.dataobject = 'd_sys_field_prop_recruiting'
lds_field_prop.settransobject( sqlca)


ls_sqlselect = lds_field_prop.Describe("DataWindow.Table.Select")

if lenA(ls_sqlselect) > 0 then
	ls_sqlselect += ' and field_order<>0 and field_id<>18035'
end if


lds_field_prop.Modify("DataWindow.Table.Select='"+ls_sqlselect+"'")

ll_rowcount = lds_field_prop.retrieve( )

For ll_i = 1 to ll_rowcount
	
		ls_text = lds_field_prop.getitemstring( ll_i,'field_name_allias')
		
		ls_field_name = lds_field_prop.getitemstring( ll_i,'field_name')
		
		li_visible = lds_field_prop.getItemNumber(ll_i,"range_from")
		
		if li_visible = 0 then
				dw_detail.modify( ls_field_name+".visible = '0'")
				dw_detail.modify( ls_field_name+"_t.visible = '0'")
				continue
		end if
		
		if (li_visible = 1 or isNull(li_visible)) and  lds_field_prop.getitemnumber( ll_i,'range_to') = 1 then
			
			if  lds_field_prop.getitemstring( ll_i,'lookup_field') = 'Y' then
					dw_detail.modify( ls_field_name+'.DDDW.Required=Yes')
				else
					
				if lower(ls_field_name) = 'pref_contact_method' then
					dw_detail.modify( ls_field_name+'.DDLB.Required=Yes')
				else
					dw_detail.modify( ls_field_name+'.Edit.Required=Yes')
				end if
				
			end if	
			dw_detail.modify( ls_field_name+".background.color = '8257535'")
		end if
		dw_detail.modify( ls_field_name+"_t.text='"+ ls_text +"'")
		
end for

destroy lds_field_prop

return 1
end function

public function long of_getpracid ();//====================================================================
//$<Function>: of_getPracid
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_prac_id

select min(prac_id) into :ll_prac_id from recruit_prac;

if isNull(ll_prac_id) or ll_prac_id > 0 then
	ll_prac_id = 0
end if	

ll_prac_id --

return ll_prac_id
end function

public function long of_triggerrowfocuschanged (long al_row);//====================================================================
//$<Function>: of_triggerrowfocuschanged
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  long
//$<Description>:  Called From setfilter
//$<Author>: (Appeon) long.zhang 10.14.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if appeonGetClientType() = "PB" THEN
	if al_row = dw_browse.getrow( ) then//Added by Appeon long.zhang 10.12.2013 (V14.1 Recruitment Functionality)
		dw_browse.event rowfocuschanged(al_row)
	end if
else	// unable to trigger rowfocuschange event under web after setfilter
	dw_browse.event rowfocuschanged(dw_browse.getrow( ))
end if

return 1
end function

public function integer of_refresh_browse (long al_loc_id);//====================================================================
//$<Function>: of_refresh_browse
//$<Arguments>:
// 	value    long    al_loc_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.15.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
	long ll_row
	
	dw_browse.retrieve( )
	of_filter_status()
	ll_row = dw_browse.find( 'rec_id='+String(al_loc_id),1,dw_browse.rowcount())	
	if ll_row > 0 then
		dw_browse.scrolltorow( ll_row)
		dw_browse.selectrow( 0,false)
		dw_browse.selectrow( ll_row,true)
	end if
	return 1
end function

public function integer of_save ();//====================================================================
//$<Function>: of_save
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.22.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row
long ll_old_loc
Integer li_rtn

li_rtn = this.event pfc_save()

if li_rtn = 1 then
	
	ll_old_loc = il_loc_id
	
	this.setredraw( false)
	
	of_refresh_browse(ll_old_loc)
	this.setredraw( true)
	
end if

return li_rtn
end function

on w_recruitment_data_search.create
int iCurrent
call super::create
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_3=create dw_3
this.ddlb_1=create ddlb_1
this.sle_1=create sle_1
this.cb_4=create cb_4
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_upload=create cb_upload
this.cb_email=create cb_email
this.cb_convert=create cb_convert
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.dw_detail=create dw_detail
this.cb_view=create cb_view
this.ddlb_filter=create ddlb_filter
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_6
this.Control[iCurrent+2]=this.rb_5
this.Control[iCurrent+3]=this.rb_4
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.ddlb_1
this.Control[iCurrent+9]=this.sle_1
this.Control[iCurrent+10]=this.cb_4
this.Control[iCurrent+11]=this.dw_2
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.cb_upload
this.Control[iCurrent+14]=this.cb_email
this.Control[iCurrent+15]=this.cb_convert
this.Control[iCurrent+16]=this.cb_delete
this.Control[iCurrent+17]=this.cb_save
this.Control[iCurrent+18]=this.cb_add
this.Control[iCurrent+19]=this.cb_close
this.Control[iCurrent+20]=this.dw_browse
this.Control[iCurrent+21]=this.dw_detail
this.Control[iCurrent+22]=this.cb_view
this.Control[iCurrent+23]=this.ddlb_filter
this.Control[iCurrent+24]=this.st_1
this.Control[iCurrent+25]=this.gb_2
this.Control[iCurrent+26]=this.gb_3
this.Control[iCurrent+27]=this.gb_4
this.Control[iCurrent+28]=this.gb_1
end on

on w_recruitment_data_search.destroy
call super::destroy
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_3)
destroy(this.ddlb_1)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_upload)
destroy(this.cb_email)
destroy(this.cb_convert)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_browse)
destroy(this.dw_detail)
destroy(this.cb_view)
destroy(this.ddlb_filter)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_1)
end on

event open;call super::open;

//dw_browse.retrieve()
//
//
//
//is_filter = "recruit_status = 1"
//of_filter_status( )
//ddlb_filter.selectitem(5)
//
end event

type rb_6 from radiobutton within w_recruitment_data_search
integer x = 50
integer y = 376
integer width = 219
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "New"
end type

type rb_5 from radiobutton within w_recruitment_data_search
integer x = 1646
integer y = 376
integer width = 169
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
end type

type rb_4 from radiobutton within w_recruitment_data_search
integer x = 283
integer y = 376
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Viewed"
end type

type rb_3 from radiobutton within w_recruitment_data_search
integer x = 1253
integer y = 376
integer width = 357
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Incomplete"
end type

type rb_2 from radiobutton within w_recruitment_data_search
integer x = 933
integer y = 376
integer width = 288
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Declined"
end type

type rb_1 from radiobutton within w_recruitment_data_search
integer x = 585
integer y = 376
integer width = 306
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Accepted"
end type

type dw_3 from u_dw within w_recruitment_data_search
integer x = 247
integer y = 532
integer width = 1454
integer height = 88
integer taborder = 80
string dataobject = "d_date_range_get"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;this.settransobject(sqlca)
this.insertrow(1)
end event

type ddlb_1 from dropdownlistbox within w_recruitment_data_search
integer x = 1893
integer y = 372
integer width = 955
integer height = 336
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Last Name","NPI #","SS #","Assigned To"}
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_recruitment_data_search
integer x = 1893
integer y = 464
integer width = 955
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_recruitment_data_search
integer x = 2930
integer y = 472
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search"
end type

type dw_2 from datawindow within w_recruitment_data_search
integer x = 2949
integer y = 360
integer width = 891
integer height = 80
integer taborder = 60
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_recruitment_data_search
integer x = 64
integer y = 660
integer width = 3959
integer height = 1396
integer taborder = 60
string title = "none"
string dataobject = "d_recruit_browse"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_upload from commandbutton within w_recruitment_data_search
boolean visible = false
integer x = 1568
integer y = 24
integer width = 119
integer height = 56
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Upload CV"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 12.20.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_prac_id
long ll_row
long ll_image_type
long ll_rec_id
long ll_data_length
integer value, li_pos, li_return,li_start
String docname,ls_filename,named,ls_filetype
boolean lb_new
pfc_cst_nv_image_functions  lnv_image_functions
Blob lb_all_data

ll_row = dw_detail.getrow( )

if ll_row < 1 then return

ll_prac_id  = dw_detail.getitemnumber( ll_row,'prac_id')

if isNull(ll_prac_id) then return


  
 SELECT Top 1 rec_id INTO :ll_rec_id
FROM recruit_image 
Where prac_id = :ll_prac_id;
	
if sqlca.sqlcode = 100 then
	lb_new = true
elseif sqlca.sqlcode < 0 then
	Messagebox( "upload cv"," - Unable to connect to DB due to "+sqlca.SQLErrText)
	return -1
end if

if not lb_new then
		if MessageBox('Upload CV','The previously uploaded CV exists for this record. Do you want to overwrite?',Question!,YesNo!,2) = 2 then
				return
			end if	
end if

value = GetFileOpenName("Select File", &
	+ docname, ls_filename, "docx", &
	 "Word Document (*.docx),*.docx," + &
	 "Word 97-2003 Document (*.doc),*.doc," + &
	 "TIFF Files (*.tif),*.tif," + &
	 "BMP Files (*.bmp),*.bmp," + &
	 "JPG Files (*.jpg),*.jpg," + &
	 "PDF Files (*.pdf),*.pdf")
	 
if value <> 1 then return

ChangeDirectory(gs_current_path)

	

li_pos = Lastpos(ls_filename,'.')
 
 ls_filetype = MidA(ls_filename,li_pos+1)

SELECT Top 1 Image_type into :ll_image_type	FROM wv_recruit_settings;

IF lb_new THEN
	
	INSERT INTO recruit_image
		(prac_id
		,image_type
		,file_name
		,file_type)
		VALUES
		(:ll_prac_id
		,:ll_image_type
		,:ls_filename
		,:ls_filetype
		);
		
ELSE
	UPDATE recruit_image
		SET image_type = :ll_image_type
		,file_name = :ls_filename
		,file_type = :ls_filetype
		Where  rec_id = :ll_rec_id;
END IF

lnv_image_functions = create pfc_cst_nv_image_functions

lb_all_data = lnv_image_functions.of_read_image_file(docname)

destroy lnv_image_functions


if lb_new then
	UpdateBlob recruit_image
	Set image_field = :lb_all_data
	Where prac_id = :ll_prac_id;
else
	UpdateBlob recruit_image
	Set image_field = :lb_all_data
	Where rec_id = :ll_rec_id;
end if

IF sqlca.SQLCode <> 0 THEN
	Messagebox( "upload cv"," Failed to upload BLOB data to DB due to "+sqlca.SQLErrText)
	rollback;
	RETURN -1
ELSE
	COMMIT;
END IF
MessageBox('upload cv','Upload CV successfully');
RETURN 1
end event

type cb_email from commandbutton within w_recruitment_data_search
integer x = 773
integer y = 16
integer width = 699
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Email Candidate"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.06.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string s
string ls_email_address
string ls_subject
string ls_notetext
string ls_attach
long ll_return

if dw_detail.getrow() < 0 then return

ls_email_address = dw_detail.getitemstring(1,"e_mail_address")

if isnull( ls_email_address) or ls_email_address = "" then
	Messagebox("Email Address",  "There is no email address for this Recruitment")
	return 1
elseif  pos(ls_email_address, "@",1) = 0 then
	Messagebox("Email Address",  "Invalid email address for this Recruitment")
	return 1	
end if



if  gi_email_type = 0 then //Start Code Change ----12.11.2012 #V12 maha - easymail changed to global variable
	open(w_general_email_send)
	w_general_email_send.sle_sendto.text = ls_email_address
elseif gi_email_type = 1 then //Start Code Change ----12.17.2012 #V12 maha - added outlook support
	n_cst_outlook lnv_Outlook
	
	Open( w_email_subject )
	IF Message.StringParm = "Cancel" THEN
		Return 1
	END IF
	
	ls_subject = Mid( Message.StringParm, 1, POS( Message.StringParm, "*" ) -1)
	ls_notetext = Mid( Message.StringParm, POS( Message.StringParm, "*" ) +1, 4000)	
	
	if lnv_Outlook.of_Logon() = -1 then
		MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
		Return 1
	end if
	
	ls_attach = ""
	ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, ls_attach)
	lnv_Outlook.of_Logoff()
	if ll_Return <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return 1
	end if	

	
end if
end event

type cb_convert from commandbutton within w_recruitment_data_search
integer x = 37
integer y = 12
integer width = 699
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Convert to Practitioner"
end type

event clicked;//maha 12.04.2004 - 	THIS FUNCIOTN WILL CURRENTLY NOT WORK WORK PROPERLY; KEY COMPONENTS COMMENTED OUT



//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row
Integer li_recruit_status
Integer li_rtn
long ll_prac_id,ll_count

ll_row = dw_detail.getrow( )

if ll_row <= 0 then return

//-------------appeon begin----------------------
//<$>added:long.zhang 11.06.2013
//<$>reason:V14.1 Recruitment Functionality Fix BugA110509
dw_detail.accepttext( )
if dw_detail.modifiedcount( ) > 0 then
	if MessageBox("Convert","Do you want to save changes?",Question!,YesNO!,1) = 1 then
		if of_save() < 0 then
			return
		end if
	end if	
end if	
//-------------appeon End------------------------

li_recruit_status = dw_detail.getitemnumber( ll_row, 'recruit_status')

if li_recruit_status <> 1 and li_recruit_status <> 2 then
//	MessageBox('Convert Data','Invalid status ,only new or viewed status can be converted')
		MessageBox('Convert Data','Invalid status ,only new or in process status can be converted')	//long.zhang 11.06.2013 BugA110506
	return
end if

ll_prac_id = dw_detail.getitemnumber( ll_row, 'prac_id')
if isNull(ll_prac_id) then return

//-------------appeon begin----------------------
//<$>added:long.zhang 11.06.2013
//<$>reason:V14.1 Recruitment Functionality Fix BugA110509
if ll_prac_id > 0 then
	select count(1) into:ll_count from pd_basic where prac_id = :ll_prac_id;
	if ll_count > 0 then
		if MessageBox('Convert','This record had been already converted before.~r~n Do you want to continue converting it to a new practitioner?',Question!,YesNo!,2) = 2 then
			return
		end if
	end if
end if
//------------appeon end-------------------------

n_cst_recruitmnet ln_recruit

ln_recruit = create n_cst_recruitmnet

//if ln_recruit.of_setparentwindow( parent) = -1 then return

this.enabled = false
//	li_rtn = ln_recruit.of_run()
this.enabled = true

destroy ln_recruit

if li_rtn = 1 then
	of_refresh_browse(il_loc_id)
end if
end event

type cb_delete from commandbutton within w_recruitment_data_search
integer x = 2665
integer y = 20
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row
long ll_prac_id
long ll_count

ll_row = dw_browse.getrow( )

if ll_row <= 0 then return

if MessageBox('Delete','Are you sure you want to delete this record',question!,YesNo!,2) = 2 then return

ll_prac_id = dw_browse.getitemnumber( ll_row,'prac_id')

if not isNull(ll_prac_id) then
	
	select count(*) into :ll_count from recruit_image where prac_id = :ll_prac_id;
	
	if ll_count > 0 then
			if MessageBox('Delete','There are '+String(ll_count)+' CV record(s) connect to this record' + &
			'.~r~n delete this record will also delete them. Are you sure you really want to delete this record?',Question!,YesNo!,2) = 2 then
				return
			end if	
	end if
	
end if

dw_browse.deleterow( 0)

if ll_count = 0 then	
	dw_browse.update( )
elseif ll_count > 0 then
	gnv_appeondb.of_startqueue( )
		dw_browse.update( )
		delete from recruit_image where prac_id = :ll_prac_id;
	gnv_appeondb.of_commitqueue( )
end if	


if ll_row = dw_browse.getrow( ) then
	dw_browse.event rowfocuschanged(ll_row)
end if

end event

type cb_save from commandbutton within w_recruitment_data_search
integer x = 1947
integer y = 20
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.05.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
of_save()

return 0
end event

type cb_add from commandbutton within w_recruitment_data_search
integer x = 2309
integer y = 20
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add(&A)"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
dw_detail.reset( )
dw_detail.insertrow( 0)
dw_detail.setitem( 1,'recruit_status',1)
dw_detail.setitem( 1,'add_date',datetime(today(),now()))
end event

type cb_close from commandbutton within w_recruitment_data_search
integer x = 3707
integer y = 20
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close(&C)"
end type

event clicked;close(parent)
end event

type dw_browse from u_dw within w_recruitment_data_search
integer x = 4210
integer y = 148
integer width = 3264
integer height = 504
integer taborder = 10
string dataobject = "d_recruit_browse"
end type

event constructor;call super::constructor;this.settransobject(sqlca)

//-------------appeon begin----------------------
//<$>added:long.zhang 10.12.2013
//<$>reason:V14.1 Recruitment Functionality BugS101108
This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(1)
//-------------appeon End------------------------
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	value    long    currentrow
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================



if currentrow > 0 then
	il_loc_id = this.getitemnumber(currentrow, "rec_id")
	dw_detail.retrieve(il_loc_id)
else
	//cb_add.event clicked()
	dw_detail.reset( )
end if	

this.selectrow(0,false)
this.selectrow(currentrow,true)
this.scrolltorow(currentrow)
end event

event clicked;call super::clicked;long r

r = this.getclickedrow()
this.setrow(r)



end event

type dw_detail from u_dw within w_recruitment_data_search
integer x = 4338
integer y = 916
integer width = 4421
integer height = 1956
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_recruit_detail"
boolean vscrollbar = false
end type

event constructor;call super::constructor;DatawindowChild ldw_child,ldw_child2

this.settransobject(sqlca)
this.of_setdropdowncalendar( true)

//-------------appeon begin----------------------
//<$>added:long.zhang 09.26.2013
//<$>reason:V14.1 Recruitment Functionality
of_modify_fieldprop()

this.of_setrowmanager(true)
this.of_setreqcolumn( true)

dw_detail.GetChild( "Board_code1", ldw_child )
ldw_child.settransobject( sqlca)

dw_detail.GetChild( "how_did_you_hear", ldw_child2 )
ldw_child2.settransobject( sqlca)

gnv_appeondb.of_startqueue( )
	ldw_child.retrieve( 'Boards')
	ldw_child2.retrieve( 'Recruitment Source')	
gnv_appeondb.of_commitqueue( )

dw_detail.GetChild( "Board_code2", ldw_child2 )
ldw_child.sharedata( ldw_child2)

dw_detail.GetChild( "Board_code3", ldw_child2 )
ldw_child.sharedata( ldw_child2)

//-------------appeon End------------------------


end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.05.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_text
	
if row = 0 then return

if dwo.name = 'b_notes' then
	
	of_expandnotes(row,'notes')
elseif dwo.name = 'b_comment' then
	
	of_expandnotes(row,'addtl_comments')
		
end if
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_rowcount
long ll_i
long ll_prac_id

setNull(ll_prac_id)

ll_rowcount = dw_detail.rowcount( )
For ll_i = 1 to ll_rowcount
	
	if this.getitemstatus( ll_i,0,primary!) = NewModified! then
		
		if isNull(ll_prac_id) then
			ll_prac_id = of_getpracid()
		else
			ll_prac_id --
		end if
		
		this.setitem( ll_i,'prac_id',ll_prac_id)
		this.setitem( ll_i,'status_change_date',datetime(today(),now()))//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
		this.setitem( ll_i,'add_date',datetime(today(),now()))	
		
	elseif 	this.getitemstatus( ll_i,0,primary!) = DataModified! then
		
		this.setitem( ll_i,'mod_date',datetime(today(),now()))
		this.setitem( ll_i,'mod_by',gs_user_id)
		
		if this.getitemstatus(ll_i,'recruit_status',primary!) = DataModified! then//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
				this.setitem( ll_i,'status_change_date',datetime(today(),now()))
		end if
		
	end if
	
end for

return 1
end event

type cb_view from commandbutton within w_recruitment_data_search
boolean visible = false
integer x = 3337
integer y = 164
integer width = 699
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View CV"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.06.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_prac_id

if dw_detail.getrow( ) <= 0 then return 

ll_prac_id = dw_detail.getitemnumber( dw_detail.getrow( ),'prac_id')

if isNull(ll_prac_id) then return

of_download_image(ll_prac_id)

end event

type ddlb_filter from dropdownlistbox within w_recruitment_data_search
boolean visible = false
integer x = 41
integer y = 20
integer width = 690
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"All","Accepted","Declined","Incomplete","New","Viewed"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
choose case index
	case 1   //all
		is_filter = ""
	case 2   //accepted
		is_filter = "recruit_status = 3"
	case 3   //declined
		is_filter = "recruit_status = 0"
	case 4   //incomplete
		is_filter = "recruit_status = -1"
	case 5   //new
		is_filter = "recruit_status = 1"
	case 6   //Viewed
		is_filter = "recruit_status = 2"
end choose

of_filter_status()
end event

type st_1 from statictext within w_recruitment_data_search
integer x = 55
integer y = 36
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Status Filter:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_recruitment_data_search
integer x = 2917
integer y = 308
integer width = 978
integer height = 156
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Position"
end type

type gb_3 from groupbox within w_recruitment_data_search
integer x = 1870
integer y = 304
integer width = 1006
integer height = 272
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Search On:"
end type

type gb_4 from groupbox within w_recruitment_data_search
integer x = 32
integer y = 312
integer width = 1819
integer height = 164
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status Filter"
end type

type gb_1 from groupbox within w_recruitment_data_search
integer x = 37
integer y = 484
integer width = 1819
integer height = 164
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range"
end type

