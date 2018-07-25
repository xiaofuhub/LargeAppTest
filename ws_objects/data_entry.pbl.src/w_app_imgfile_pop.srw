$PBExportHeader$w_app_imgfile_pop.srw
forward
global type w_app_imgfile_pop from pfc_w_response
end type
type uo_app from pfc_cst_u_create_app2 within w_app_imgfile_pop
end type
type ole_scan from olecustomcontrol within w_app_imgfile_pop
end type
type cb_preview from commandbutton within w_app_imgfile_pop
end type
type cb_close from commandbutton within w_app_imgfile_pop
end type
type cb_scan from commandbutton within w_app_imgfile_pop
end type
type cb_file from commandbutton within w_app_imgfile_pop
end type
type gb_options from groupbox within w_app_imgfile_pop
end type
end forward

global type w_app_imgfile_pop from pfc_w_response
integer x = 214
integer y = 221
integer width = 645
integer height = 692
boolean titlebar = false
boolean controlmenu = false
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
uo_app uo_app
ole_scan ole_scan
cb_preview cb_preview
cb_close cb_close
cb_scan cb_scan
cb_file cb_file
gb_options gb_options
end type
global w_app_imgfile_pop w_app_imgfile_pop

type variables
long	il_rec_id,il_prac_id,il_app_id
integer ii_return
string is_type
string is_file_name  //maha 05.17.2016
end variables

forward prototypes
public function integer of_saveimage (string as_image_path, string as_filename)
public function long of_down_image (long al_rec_id, long al_prac_id, long al_app_id)
end prototypes

public function integer of_saveimage (string as_image_path, string as_filename);//====================================================================
//$<Function>: of_SaveImage
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.15.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================


String		ls_ImagePath
long			ll_Cnts,ll_FileNo,ll_ReadCnts
Blob			lblb_ImageData,lblb_Buffer
DateTime		ldt_SaveTime
n_cst_dm_utils lnv_utils
long ll_ImgType = 5

ldt_SaveTime = f_get_server_dtm()

SELECT Count(*) INTO :ll_Cnts FROM net_dev_action_images WHERE rec_id = :il_rec_id ; 
if ll_Cnts <= 0 then
	INSERT INTO net_dev_action_images(rec_id,prac_id,app_id,image_type,save_date, file_name)
		  VALUES (:il_rec_id,:il_prac_id,:il_app_id,:ll_ImgType,:ldt_SaveTime, :as_filename) ;
else
	UPDATE net_dev_action_images
	   SET save_date = :ldt_SaveTime,
		     app_id = :il_app_id,
		     file_name = :as_filename
	 WHERE rec_id = :il_rec_id ;
end if
debugbreak()
//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 07.27.2015
//<$>reason:Bug id 4628 - Printed Application is Blurry
if lnv_utils.of_ReadBlob(as_image_path, lblb_ImageData) = -1 then //(APPEON)Harry 05.26.2016 modify as_filename to as_image_path
	Return -1
End If
//ls_ImagePath = as_image_path
//ll_FileNo = FileOpen(ls_ImagePath,StreamMode!,Read!)
//if ll_FileNo <= 0 then Return 1
//
//ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
//do while ll_ReadCnts > 0
//	lblb_ImageData += lblb_Buffer
//	ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
//loop
//
//FileClose(ll_FileNo)
//------------------- APPEON END -------------------

UPDATEBLOB net_dev_action_images
       SET image_data = :lblb_ImageData
		WHERE rec_id = :il_rec_id ; 

COMMIT USING SQLCA ;

Messagebox("Upload Application File","The Upload is Completed!")
ii_return = 1
return 1

end function

public function long of_down_image (long al_rec_id, long al_prac_id, long al_app_id);//====================================================================
//$<Function>: of_down_image
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.16.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long		ll_FileNo,ll_Cycle,ll_DataLen,ll_Count,ll_Start, ll_Pos
long 		READ_ONE_COUNT = 8000
Blob		lblb_Buffer
string     ls_filename, ls_Null, ls_fileext
string ls_params

SELECT Datalength(net_dev_action_images.image_data), file_name
  INTO :ll_DataLen, :ls_filename
  FROM net_dev_action_images
 WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;

if IsNull(ll_DataLen) or ll_DataLen <= 0 then 
	messagebox("Prompt", "There is no Application file uploaded!")
	Return -1
end if

//---------Begin Added by (Appeon)Alfee 12.17.2014----------------------------------------
//<$Reason>For images stored via printing app - BugA121702
if IsNull(ls_filename) or Len(Trim(ls_filename))  < 1 then
	ls_filename = String(al_rec_id) + "_" + String(al_prac_id) + "_"  + String(al_app_id) + ".tif"
end if
//---------End Added ----------------------------------------------------------------------------

SetPointer (HourGlass!)
openwithparm( w_appeon_gifofwait, "Downloading Application file from Database..." )

ls_filename = gs_temp_path + "Images\"+ ls_filename

is_file_name = ls_filename  //Start Code Change ----05.17.2016 #V152 maha

ll_FileNo = FileOpen(ls_filename,StreamMode!,Write!,LockReadWrite!,Replace!)
if ll_FileNo <= 0 then Return -1

ll_Count = Ceiling(ll_DataLen/READ_ONE_COUNT)

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_COUNT then
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_COUNT + 1
		SELECTBLOB SubString(image_data,:ll_Start,:READ_ONE_COUNT)
		      INTO :lblb_Buffer
		      FROM net_dev_action_images
		     WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;
		
		FileWrite(ll_FileNo,lblb_Buffer)
	next
else
	SELECTBLOB image_data
	      INTO :lblb_Buffer
	      FROM net_dev_action_images
 		  WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;
	
	for ll_Cycle = 1 To ll_Count
		FileWrite(ll_FileNo,BlobMid(lblb_Buffer,(ll_Cycle - 1) * READ_ONE_COUNT + 1,READ_ONE_COUNT))
	next
end if

FileClose(ll_FileNo)
SetPointer (Arrow!)
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

IF Not FileExists( ls_filename) THEN 
	MessageBox("File Creation Error", "No Application file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
END IF

setnull(ls_Null)
IF FileExists(ls_filename) THEN
	//---------Begin Modified by (Appeon)Alfee 10.22.2013 ---------------------
	ll_Pos = LastPos (ls_filename, "." )
	IF ll_Pos > 0 THEN ls_fileext = Mid (ls_filename, ll_Pos + 1, 3) 
	debugbreak()
	IF Upper(ls_fileext) = "TIF" THEN
		//Start Code Change ----05.17.2016 #V152 maha - open in edit window
		if w_mdi.of_security_access(7822) = 0 then  // edit saved app
			IF Isvalid(w_image_display) THEN Close (w_image_display) 
			OpenWithParm(w_image_display,ls_filename)
		else
			IF Isvalid(w_preview_app) THEN Close (w_preview_app) 
			ls_params = ls_filename + "||" + "" + "||" + "" + "||" + "" +  "||" + string(il_prac_id) + "||" + string(il_rec_id) + "||" + string(il_app_id) 
			OpenWithParm(w_preview_app_popup , ls_params)
		end if
		//End Code Change ----05.17.2016
	ELSE
		ShellExecuteA ( Handle( This ), "open", ls_filename, ls_Null, ls_Null, 1)		
	END IF
	//ShellExecuteA ( Handle( This ), "open", ls_filename, ls_Null, ls_Null, 1)
	//---------End Modfiied ----------------------------------------------------------------
END IF

Return 1


end function

on w_app_imgfile_pop.create
int iCurrent
call super::create
this.uo_app=create uo_app
this.ole_scan=create ole_scan
this.cb_preview=create cb_preview
this.cb_close=create cb_close
this.cb_scan=create cb_scan
this.cb_file=create cb_file
this.gb_options=create gb_options
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_app
this.Control[iCurrent+2]=this.ole_scan
this.Control[iCurrent+3]=this.cb_preview
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_scan
this.Control[iCurrent+6]=this.cb_file
this.Control[iCurrent+7]=this.gb_options
end on

on w_app_imgfile_pop.destroy
call super::destroy
destroy(this.uo_app)
destroy(this.ole_scan)
destroy(this.cb_preview)
destroy(this.cb_close)
destroy(this.cb_scan)
destroy(this.cb_file)
destroy(this.gb_options)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.15.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
str_parm lstr_img

lstr_img = message.powerobjectparm
il_app_id = lstr_img.l_wf_id 
il_rec_id =  lstr_img.l_doc_id 
il_prac_id = lstr_img.l_ctx_id
is_type = lstr_img.s_type
is_file_name =  lstr_img.s_module
  

if lower(is_type) = 'exist' then  //Start Code Change ----05.17.2016 #V152 maha - was 'old'
	cb_file.enabled = false
	cb_scan.enabled = false
	//gb_options.text = "Replace Existing"
elseif lower(is_type) = 'new' then  //Start Code Change ----05.04.2016 #V152 maha
	cb_preview.enabled = false
end if

ii_return = -1
end event

type uo_app from pfc_cst_u_create_app2 within w_app_imgfile_pop
boolean visible = false
integer x = 1289
integer y = 404
integer width = 151
integer height = 152
integer taborder = 10
end type

on uo_app.destroy
call pfc_cst_u_create_app2::destroy
end on

type ole_scan from olecustomcontrol within w_app_imgfile_pop
event scanstarted ( )
event scandone ( )
event pagedone ( long pagenumber )
event scanuidone ( )
event filenamerequest ( long pagenumber )
boolean visible = false
integer x = 1234
integer y = 540
integer width = 146
integer height = 128
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_app_imgfile_pop.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_preview from commandbutton within w_app_imgfile_pop
integer x = 87
integer y = 348
integer width = 466
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Preview"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.16.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_fileext  //maha 05.19.2016
integer ll_pos   //maha 05.19.2016
string ls_params


//Start Code Change ----05.19.2016 #V152 maha - modified to open if file exists on hard drive
if is_file_name = "" then
	of_down_image(il_rec_id,il_prac_id,il_app_id)
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
else
	if w_mdi.of_security_access(7822) = 0 then  // edit saved app
		IF Isvalid(w_image_display) THEN Close (w_image_display) 
		OpenWithParm(w_image_display, is_file_name)
	else
		post close(parent)
		ls_params = is_file_name + "||" + "" + "||" + "" + "||" + "" +  "||" + string(il_prac_id) + "||" + string(il_rec_id) + "||" + string(il_app_id) 
		OpenWithParm(w_preview_app,ls_params)
				
		ll_Pos = LastPos (is_file_name, "." )
		IF ll_Pos > 0 THEN ls_fileext = Mid (is_file_name, ll_Pos + 1, 3) 	
	end if
end if

//close(parent)
//End Code Change ----05.19.2016






end event

type cb_close from commandbutton within w_app_imgfile_pop
integer x = 82
integer y = 532
integer width = 466
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;closewithreturn(parent, ii_return)
end event

type cb_scan from commandbutton within w_app_imgfile_pop
integer x = 91
integer y = 196
integer width = 466
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Scan"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.16.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_scan_file, ls_filename
pfc_cst_nv_image_functions image_functions

image_functions = CREATE pfc_cst_nv_image_functions

ls_scan_file = gs_temp_path + "scan" + string(il_rec_id) + ".tif"
ls_filename = "scan" + string(il_rec_id) + ".tif"
filedelete(ls_scan_file)

IF image_functions.of_Setup_Scan( ole_scan, ls_scan_file, 1 ) = -1 THEN
	DESTROY image_functions
	Return -1
END IF

DESTROY image_functions

// Upload Image file
of_saveimage(ls_scan_file, ls_filename)
closewithreturn(parent, ii_return)
end event

type cb_file from commandbutton within w_app_imgfile_pop
integer x = 87
integer y = 88
integer width = 466
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select  from File"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.15.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string docpath, docname
string ls_ext, ls_filename
integer li_rtn, li_page

li_rtn = GetFileOpenName("Select File", 	docpath, docname, "TIF",  "TIFF Files (*.tif),*.tif, PDF Files (*.pdf),*.pdf") 

ChangeDirectory(gs_current_path)

IF li_rtn < 1 THEN RETURN 
// Upload Image file
//---------Begin Added by (Appeon)Stephen 03.11.2015 for Bug #4438: Blank emails being sent - Privia Health --------
ls_ext = right(docname, 4)
ls_filename = docpath
if lower(ls_ext) = '.tif' then
	docname = trim(docname)
	docname = left(docname, len(docname) - 4)+"_b.tif"
	ls_filename = left(docpath, lastpos(docpath, "\")) + docname
	if FileExists(ls_filename) then FileDelete(ls_filename)
	if filecopy(docpath, ls_filename) <> 1 then 
		messagebox("Prompt", "Unable to select the file, please try again!")
		return
	end if
	uo_app.ole_edit.object.image = ls_filename
	for li_page = 1 to uo_app.ole_edit.Object.PageCount()
		uo_app.ole_edit.Object.Page(li_page)
		uo_app.ole_edit.Object.Display()
		uo_app.ole_edit.Object.BurnInAnnotations( 1, 2 )	
		uo_app.ole_edit.Object.save()
	next
	ls_filename = uo_app.ole_edit.Object.Image()
end if
//---------End Added ------------------------------------------------------

of_saveimage(ls_filename, docname)
closewithreturn(parent, ii_return)

end event

type gb_options from groupbox within w_app_imgfile_pop
integer x = 59
integer y = 16
integer width = 521
integer height = 304
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Import Options"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_app_imgfile_pop.bin 
2C00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000cb300cd001d1bffd00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000013900000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff0000000384926ca0101c2941600e6f817f4b111300000000cb300cd001d1bffdcb300cd001d1bffd000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000005000000430000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe0002020684926ca0101c2941600e6f817f4b111300000001fb8f0821101b01640008ed8413c72e2b00000030000001090000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000007400000000000000840000000300010000000000030000034f000000030000034f00000003000000000000001e0000000945676d4931746964000000000000001e00000006696177540000006e00000007000000000000000100010500000010006c657300657463656163736472656e6e0001030000000c0074735f00706b636f73706f72000104000000110073656400616d69746f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f69730000000000000000000100000000034f0000034f00000000676d490874696445000100310001000000007fff00000001000100000003000100000008000000000142c8006177540500006e6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_app_imgfile_pop.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
