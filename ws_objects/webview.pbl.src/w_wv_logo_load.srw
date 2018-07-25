$PBExportHeader$w_wv_logo_load.srw
forward
global type w_wv_logo_load from w_sheet
end type
type dw_facility from u_dw within w_wv_logo_load
end type
type st_1 from statictext within w_wv_logo_load
end type
type cb_close from commandbutton within w_wv_logo_load
end type
type cb_load from commandbutton within w_wv_logo_load
end type
type sle_1 from singlelineedit within w_wv_logo_load
end type
type p_1 from picture within w_wv_logo_load
end type
type cb_browse from commandbutton within w_wv_logo_load
end type
type gb_1 from groupbox within w_wv_logo_load
end type
type gb_2 from groupbox within w_wv_logo_load
end type
type gb_3 from groupbox within w_wv_logo_load
end type
end forward

global type w_wv_logo_load from w_sheet
integer width = 2203
integer height = 1100
string title = "WebView Logo Upload"
boolean maxbox = false
long backcolor = 33551856
dw_facility dw_facility
st_1 st_1
cb_close cb_close
cb_load cb_load
sle_1 sle_1
p_1 p_1
cb_browse cb_browse
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_wv_logo_load w_wv_logo_load

type variables
boolean ib_save
boolean ib_new = false
end variables

forward prototypes
public function integer of_get_logo ()
public function integer of_get_logo (long al_facility)
public function integer of_upload_logo (long al_facility)
end prototypes

public function integer of_get_logo ();//////////////////////////////////////////////////////////////////////
// $<function> of_get_logo
// $<arguments>
// $<returns> integer
// $<description> Logo Image (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 02.24.2012 by Stephen
//////////////////////////////////////////////////////////////////////

Long li_filenum
Long ll_filelen, ll_start
Long  ll_data_length
Integer li_loops
Integer li_counter
Blob  lb_image_data
Blob blob_temp
Blob total_blob
string ls_file, ls_Null,ls_type
String ls_filename
long   ll_image_id

SetPointer(HourGlass!)
//select top 1 image_id, image_type into :ll_image_id, :ls_type from wv_images;
select top 1 image_id, image_type into :ll_image_id, :ls_type from wv_images where image_id=0;//long.zhang 12.20.2012 v12.3 pracview logo changed
ls_filename = "wv_logo." + trim(ls_type)

ls_file = gs_temp_path + "images\"  
gnv_appeondll.of_parsepath(ls_file)
ls_file = ls_file + ls_filename

IF FileExists(ls_file) THEN
	filedelete(ls_file)
END IF

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	
	SELECT top 1 Datalength(image_data)
	INTO     :ll_data_length
	FROM    wv_images
  WHERE    image_id = :ll_image_id
	USING   SQLCA;
	
	//IF SQLCA.SQLCODE <> 0 THEN
	IF SQLCA.SQLCODE =  -1 THEN	//bug011801- alfee 01.28.2013
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	END IF

	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
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
		SELECTBLOB substring(image_data,:ll_start,8000)
		INTO :blob_temp
		FROM wv_images
		where image_id = :ll_image_id
	    USING  SQLCA;
	
		total_blob += blob_temp
	NEXT 
	
	lb_image_data = total_blob
ELSE
	SELECTBLOB image_data 
	INTO :lb_image_data
	FROM wv_images 
	WHERE image_id = :ll_image_id
	   USING  SQLCA;
	
END IF

IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
IF SQLCA.SQLCODE <> 0 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1

IF Not FileExists( ls_file) THEN 
	MessageBox("File Creation Error", "No document created.  Check to make sure the directory " + gs_dir_path + " is valid." )
END IF

p_1.PictureName = ls_file
setPointer(Arrow!)
Return 1

end function

public function integer of_get_logo (long al_facility);//====================================================================
// $<function> of_get_logo
// $<arguments> long al_facility
// $<returns> integer
// $<description> get logo based on different facility (V12.3 PracView logo changed)
// $<add> 12.20.2012 by long.zhang
//Copied and Modified from of_get_logo()
//====================================================================

Long li_filenum
Long ll_filelen, ll_start
Long  ll_data_length
Integer li_loops
Integer li_counter
Blob  lb_image_data
Blob blob_temp
Blob total_blob
string ls_file, ls_Null,ls_type
String ls_filename
long   ll_image_id

SetPointer(HourGlass!)
setNull(ll_image_id)

select top 1 image_id, image_type into :ll_image_id, :ls_type from wv_images where facility_id=:al_facility;
if isNull(ll_Image_id) then 
	setPointer(Arrow!)
	p_1.PictureName = ""
	return -1
end if
ls_filename = "wv_logo_" +String(al_facility)+"." + trim(ls_type)

ls_file = gs_temp_path + "images\"  
gnv_appeondll.of_parsepath(ls_file)
ls_file = ls_file + ls_filename

IF FileExists(ls_file) THEN
	filedelete(ls_file)
END IF

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	
	SELECT top 1 Datalength(image_data)
	INTO     :ll_data_length
	FROM    wv_images
  WHERE    image_id = :ll_image_id
	USING   SQLCA;
	
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	END IF

	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
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
		SELECTBLOB substring(image_data,:ll_start,8000)
		INTO :blob_temp
		FROM wv_images
		where image_id = :ll_image_id
	    USING  SQLCA;
	
		total_blob += blob_temp
	NEXT 
	
	lb_image_data = total_blob
ELSE
	SELECTBLOB image_data 
	INTO :lb_image_data
	FROM wv_images 
	WHERE image_id = :ll_image_id
	   USING  SQLCA;
	
END IF

IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
IF SQLCA.SQLCODE <> 0 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1

IF Not FileExists( ls_file) THEN 
	MessageBox("File Creation Error", "No document created.  Check to make sure the directory " + gs_dir_path + " is valid." )
END IF

p_1.PictureName = ls_file
setPointer(Arrow!)
Return 1

end function

public function integer of_upload_logo (long al_facility);//====================================================================
// $<function> of_upload_logo
// $<arguments> long al_facility
// $<returns> integer
// $<description> upload logo based on different facility (V12.3 PracView logo changed)
// $<add> 12.20.2012 by long.zhang
//$<remark> copied and modified from cb_load.clicked event
//====================================================================
String 	 ls_func_type
Integer 	 li_row
blob       lb_doc
pfc_cst_nv_image_functions lnv_image_functions
string  ls_file, ls_type
long    ll_image_id
datetime ldt_time
long ll_id
SetPointer(HourGlass!)

ib_save = true
ls_file = sle_1.text
if not ib_new then return 1

if  not(isnull(ls_file) or ls_file = '')  then
	
	if messagebox("Prompt", "Are you sure you want to replace the logo on the web with the new one?", question!, YesNo!) = 2 then return 1
	
	if not fileexists(ls_file) then
		MessageBox("Reminder","The file '" + ls_file  +"'does not exist. ")  
		ib_save = false
		return -1
	end if
	
	ls_type = mid(ls_file, lastpos(ls_file, ".") + 1)
	if not isvalid(w_appeon_gifofwait) then
		openwithparm( w_appeon_gifofwait, "logo uploading..." )
	end if

	lnv_image_functions = create pfc_cst_nv_image_functions
	lb_doc = lnv_image_functions.of_read_image_file( ls_file )
	select top 1 image_id into :ll_image_id from wv_images where facility_id = :al_facility using sqlca;
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode = 100 then
			
			if al_facility = 0 then
				ll_id = 0		
			else
				select max(image_id) into :ll_id from wv_images;
				if isNULl(ll_id) then ll_id=0
				ll_id++
			end if
			
			insert into wv_images(image_id,facility_id) values(:ll_id,:al_facility);
			ll_image_id = ll_id
		else
			MessageBox("Prompt","Logo Save failed!")
			ib_save = false
			destroy lnv_image_functions
			Return -1;
		end if
	end if
//	ls_file = mid(ls_file, 1,lastpos(ls_file, "\"))
//	ls_file +=  "wv_logo_" +String(al_facility)+"." + trim(ls_type)
	
	update wv_images 
	      set image_type = :ls_type ,
			 file_name = :ls_file,
			 upload_time = getdate()
			where  image_id = :ll_image_id using sqlca;
			
	updateblob wv_images 
			  set  image_data  = :lb_doc
		  where  image_id = :ll_image_id using sqlca;

	if sqlca.sqlcode <> 0 then
		MessageBox("Prompt","Logo Save failed!")
		ROLLBACK using sqlca;
		ib_save = false
		Return -1;
	end if
	
	COMMIT using sqlca;
	
	destroy lnv_image_functions
	if  isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	MessageBox("Prompt","Logo was successfully saved!")
	ib_new = false
	cb_load.enabled = false
	sle_1.text = ''
end if	
return 1
end function

on w_wv_logo_load.create
int iCurrent
call super::create
this.dw_facility=create dw_facility
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_load=create cb_load
this.sle_1=create sle_1
this.p_1=create p_1
this.cb_browse=create cb_browse
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_facility
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_load
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.p_1
this.Control[iCurrent+7]=this.cb_browse
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_wv_logo_load.destroy
call super::destroy
destroy(this.dw_facility)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_load)
destroy(this.sle_1)
destroy(this.p_1)
destroy(this.cb_browse)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> Web logo upload (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.22.2012 by Stephen
// $<modify> 03.20.2012 by Evan --- Fixed bug
//////////////////////////////////////////////////////////////////////

integer li_Exists, li_cnt

gnv_appeondb.of_startqueue( )
if gs_DBType = "ASA" then
	select Count(*) into :li_Exists from sys.syscolumn c,sys.systable t where c.table_id=t.table_id and
	c.column_name='upload_time' and t.table_name='wv_images';
else
	select Count(*) into :li_Exists from syscolumns c, sysobjects t where c.id=t.id and
	c.name='upload_time' and t.name='wv_images' and t.type = 'U';
end if
select count(1) into :li_cnt from wv_images;
gnv_appeondb.of_commitqueue( )

if IsNull(li_Exists) or li_Exists <> 1 then
	MessageBox("Warning", "This module is unavailable currently because the logo file hasn't been upgraded in WebView.", Exclamation!)
	Close(this)
	Return
end if

if sqlca.sqlcode <> 0 or li_cnt < 1 then
else
	of_get_logo()
end if
end event

event closequery;call super::closequery;//////////////////////////////////////////////////////////////////////
// $<event> closequery
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.24.2012 by Stephen
//////////////////////////////////////////////////////////////////////
if ib_new then
	cb_load.event clicked()
	if not ib_save then return 1
end if
end event

type dw_facility from u_dw within w_wv_logo_load
integer x = 69
integer y = 100
integer width = 974
integer height = 92
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_wv_facility_select"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) long.zhang  12.20.2012
//====================================================================

datawindowchild ldwc_child

this.of_SetUpdateAble(false)
this.GetChild("facility_id", ldwc_child)

ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve(gs_user_id)
ldwc_child.InsertRow(1)
ldwc_child.SetItem(1, "facility_facility_id", 0)
ldwc_child.SetItem(1, "facility_facility_name", "ALL")
ldwc_child.SelectRow(0, false)

this.InsertRow(1)
this.SetItem(1, "facility_id", 0)
end event

event itemchanged;call super::itemchanged;//====================================================================
// $<event> ItemChanged()
// $<arguments>
// $<returns> long
// $<description> get logo based on different facility
// $<add> (Appeon) long.zhang  12.20.2012
//====================================================================

of_get_logo(long(data))

end event

type st_1 from statictext within w_wv_logo_load
integer x = 73
integer y = 892
integer width = 1138
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Accepted file formats are gif/jpg/jpeg/png/bmp."
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_wv_logo_load
integer x = 1774
integer y = 68
integer width = 320
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_load from commandbutton within w_wv_logo_load
integer x = 1417
integer y = 64
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Upload"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.24.2012 by Stephen
//////////////////////////////////////////////////////////////////////

//------------------appeon begin---------------------
//<$>added:long.zhang 12.20.2012
//<$>reason:v 12.3 pracview logo changed
long ll_facility_id
ll_facility_id = dw_facility.getItemNumber(1,"facility_id")
of_upload_logo(ll_facility_id)
//-----------------appeon end-------------------------

//--------------------appeon begin--------------------
//<$>Commented:long.zhang 12.20.2012
//<$>reason: replace these codes with of_upload_logo function v 12.3 pracview logo changed

//String 	 ls_func_type
//Integer 	 li_row
//blob       lb_doc
//pfc_cst_nv_image_functions lnv_image_functions
//string  ls_file, ls_type
//long    ll_image_id
//datetime ldt_time
//
//SetPointer(HourGlass!)
//
//ib_save = true
//ls_file = sle_1.text
//if not ib_new then return 1
//
//if  not(isnull(ls_file) or ls_file = '')  then
//	
//	if messagebox("Prompt", "Are you sure you want to replace the logo on the web with the new one?", question!, YesNo!) = 2 then return 1
//	
//	if not fileexists(ls_file) then
//		MessageBox("Reminder","The file '" + ls_file  +"'does not exist. ")  
//		ib_save = false
//		return -1
//	end if
//	
//	ls_type = mid(ls_file, lastpos(ls_file, ".") + 1)
//	if not isvalid(w_appeon_gifofwait) then
//		openwithparm( w_appeon_gifofwait, "logo uploading..." )
//	end if
//
//	lnv_image_functions = create pfc_cst_nv_image_functions
//	lb_doc = lnv_image_functions.of_read_image_file( ls_file )
//	select top 1 image_id into :ll_image_id from wv_images using sqlca;
//	if sqlca.sqlcode <> 0 then
//		if sqlca.sqlcode = 100 then
//			insert into wv_images(image_id) values(0);
//			ll_image_id = 0			
//		else
//			MessageBox("Prompt","Logo Save failed!")
//			ib_save = false
//			destroy lnv_image_functions
//			Return -1;
//		end if
//	end if
//	
//	update wv_images 
//	      set image_type = :ls_type ,
//			 file_name = :ls_file,
//			 upload_time = getdate()
//			where  image_id = :ll_image_id using sqlca;
//			
//	updateblob wv_images 
//			  set  image_data  = :lb_doc
//		  where  image_id = :ll_image_id using sqlca;
//
//	if sqlca.sqlcode <> 0 then
//		MessageBox("Prompt","Logo Save failed!")
//		ROLLBACK using sqlca;
//		ib_save = false
//		Return -1;
//	end if
//	
//	COMMIT using sqlca;
//	
//	destroy lnv_image_functions
//	if  isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
//	MessageBox("Prompt","Logo was successfully saved!")
//	ib_new = false
//	cb_load.enabled = false
//	sle_1.text = ''
//end if	
//--------------------------appeon end--------------------


end event

type sle_1 from singlelineedit within w_wv_logo_load
integer x = 73
integer y = 776
integer width = 1637
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within w_wv_logo_load
integer x = 73
integer y = 276
integer width = 1678
integer height = 432
end type

type cb_browse from commandbutton within w_wv_logo_load
integer x = 1733
integer y = 776
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Browse..."
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.24.2012 by Stephen
//////////////////////////////////////////////////////////////////////
string docname, named

integer value, li_pos, li_return


value = GetFileOpenName("Select File", &
	+ docname, named, "BMP","BMP Files (*.bmp),*.bmp," + &
	 "JPG Files (*.jpg),*.jpg," + &
	 "JPEG Files (*.jpeg),*.jpeg," + &
	 "GIF Files (*.gif),*.gif," + &
	 "PNG Files (*.png),*.png" )
	
ChangeDirectory(gs_current_path)

if value <> 1 then return
sle_1.text = docname
p_1.picturename = docname
ib_new = true
cb_load.enabled = true
end event

type gb_1 from groupbox within w_wv_logo_load
integer x = 32
integer y = 220
integer width = 2075
integer height = 512
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type gb_2 from groupbox within w_wv_logo_load
integer x = 32
integer y = 724
integer width = 2075
integer height = 244
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type gb_3 from groupbox within w_wv_logo_load
integer x = 32
integer y = 28
integer width = 1029
integer height = 184
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Facility"
end type

