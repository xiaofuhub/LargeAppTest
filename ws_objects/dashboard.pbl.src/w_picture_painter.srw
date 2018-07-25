$PBExportHeader$w_picture_painter.srw
forward
global type w_picture_painter from w_response
end type
type cb_select from commandbutton within w_picture_painter
end type
type cb_previewall from commandbutton within w_picture_painter
end type
type cb_delete from commandbutton within w_picture_painter
end type
type cb_update_pic from commandbutton within w_picture_painter
end type
type p_2 from picture within w_picture_painter
end type
type st_4 from statictext within w_picture_painter
end type
type sle_filename from singlelineedit within w_picture_painter
end type
type st_8 from statictext within w_picture_painter
end type
type st_ext from statictext within w_picture_painter
end type
type st_6 from statictext within w_picture_painter
end type
type cb_refresh from commandbutton within w_picture_painter
end type
type mle_desc from multilineedit within w_picture_painter
end type
type st_size from statictext within w_picture_painter
end type
type st_zoom from statictext within w_picture_painter
end type
type st_width from statictext within w_picture_painter
end type
type st_height from statictext within w_picture_painter
end type
type st_3 from statictext within w_picture_painter
end type
type st_2 from statictext within w_picture_painter
end type
type st_1 from statictext within w_picture_painter
end type
type st_5 from statictext within w_picture_painter
end type
type p_1 from picture within w_picture_painter
end type
type dw_picture from u_dw within w_picture_painter
end type
type cb_stop from commandbutton within w_picture_painter
end type
type hpb_progress from hprogressbar within w_picture_painter
end type
type st_progress from statictext within w_picture_painter
end type
type cb_import_pic from commandbutton within w_picture_painter
end type
type cb_close from commandbutton within w_picture_painter
end type
type cb_save from commandbutton within w_picture_painter
end type
type gb_2 from groupbox within w_picture_painter
end type
type gb_preview from groupbox within w_picture_painter
end type
type gb_4 from groupbox within w_picture_painter
end type
end forward

global type w_picture_painter from w_response
integer width = 4603
integer height = 2072
string title = "Picture Painter"
long backcolor = 33551856
event ue_systemcommand pbm_syscommand
cb_select cb_select
cb_previewall cb_previewall
cb_delete cb_delete
cb_update_pic cb_update_pic
p_2 p_2
st_4 st_4
sle_filename sle_filename
st_8 st_8
st_ext st_ext
st_6 st_6
cb_refresh cb_refresh
mle_desc mle_desc
st_size st_size
st_zoom st_zoom
st_width st_width
st_height st_height
st_3 st_3
st_2 st_2
st_1 st_1
st_5 st_5
p_1 p_1
dw_picture dw_picture
cb_stop cb_stop
hpb_progress hpb_progress
st_progress st_progress
cb_import_pic cb_import_pic
cb_close cb_close
cb_save cb_save
gb_2 gb_2
gb_preview gb_preview
gb_4 gb_4
end type
global w_picture_painter w_picture_painter

type variables
Long il_count
Boolean ib_stop
n_cst_dm_utils inv_utils

Long ll_picture_control_org_width
Long ll_picture_control_org_height

str_picture istr_picture, istr_null
Boolean ib_select_mode = False
Long il_default_id = 0

Boolean ib_running = False
end variables

forward prototypes
public subroutine of_preview_logo (string ls_file_name, ref long al_logo_height, ref long al_logo_width)
public function integer of_upload_picture (string as_file, long al_pic_id, ref string as_error)
public function integer of_preview_file (string as_file)
public function integer of_reset ()
public subroutine of_refresh (boolean ab_refresh_pic)
public subroutine of_refresh ()
end prototypes

event ue_systemcommand;If message.wordparm = 61536 Then
	cb_close.Trigger Event Clicked()
End If

end event

public subroutine of_preview_logo (string ls_file_name, ref long al_logo_height, ref long al_logo_width);
end subroutine

public function integer of_upload_picture (string as_file, long al_pic_id, ref string as_error);//====================================================================
// Function: of_upload_picture
//--------------------------------------------------------------------
// Description: Upload Picture to DB
//--------------------------------------------------------------------
// Arguments:
//                as_file
//                al_pic_id
//                as_error
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 02/06/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Blob lblb_data
Integer li_exists
Long ll_height, ll_width, ll_filesize
String ls_ext, ls_filename

//Check File
If Not FileExists(as_file) Then 
	as_error = 'File is not existis.' + as_file + '.'
	Return -1
End If

//Get File Blob
If inv_utils.of_readblob(as_file,lblb_data) < 0 Then
	as_error = 'Failed to read file.' + as_file + '.'
	Return -2
End If

//Get File Attrible
p_2.PictureName = as_file
//ll_height = p_2.height
//ll_width = p_2.width

ll_height =   Long(UnitsToPixels(p_2.height, YUnitsToPixels!)) 
ll_width =   Long(UnitsToPixels(p_2.width, XUnitsToPixels!)) 

ll_filesize = FileLength(as_file)
ls_ext = Mid( as_file, lastpos(as_file,'.') + 1 )

ls_filename = Mid( as_file, lastpos(as_file, '\') + 1, lastpos(as_file,'.') - lastpos(as_file,'\') - 1  )

Select count(1) Into :li_exists From ctx_pictures Where id = :al_pic_id; 

If li_exists > 0  Then
	Update ctx_pictures Set file_ext = :ls_ext, file_height = :ll_height, file_width = :ll_width, 
				file_size = :ll_filesize, last_modified = getdate() Where id = :al_pic_id;
	UpdateBlob ctx_pictures Set file_image = :lblb_data Where id = :al_pic_id;
Else
	Insert Into ctx_pictures(id, file_name, file_ext, file_height, file_width, file_size, last_modified) 
		Values(:al_pic_id, :ls_filename, :ls_ext, :ll_height, :ll_width, :ll_filesize, Getdate() ) ;
	UpdateBlob ctx_pictures Set file_image = :lblb_data Where id = :al_pic_id;	
End If

If sqlca.sqlcode <> 0 Then
	as_error = 'Failed to update file to DB.' + as_file + '. ' + sqlca.sqlerrtext
	Return -3
End If

Return 1
end function

public function integer of_preview_file (string as_file);Long ll_logo_width,ll_logo_height, li_size
Decimal{2} ldec_zoom_w,ldec_zoom_h

//This.SetRedraw(False)
p_1.Setredraw( False )
p_1.originalsize = True
p_1.picturename = as_file
ll_logo_width = p_1.width
ll_logo_height = p_1.height
If ll_logo_width > ll_picture_control_org_width Then
	p_1.width = ll_picture_control_org_width
	ldec_zoom_w = ll_picture_control_org_width/ll_logo_width
	p_1.height = ll_logo_height * ldec_zoom_w
	p_1.originalsize = False
End If
If ll_logo_height > ll_picture_control_org_height Then
	ldec_zoom_h = ll_picture_control_org_height/ll_logo_height
	If ldec_zoom_h < ldec_zoom_w Or ldec_zoom_w = 0 Then
		p_1.height = ll_picture_control_org_height
		p_1.width = ll_logo_width * ldec_zoom_h
		p_1.originalsize = False
	End If
End If

//st_height.text =  String(ll_logo_height) 
//st_width.text =  String(ll_logo_width) 

st_height.text =  String( Long(UnitsToPixels(ll_logo_height, YUnitsToPixels!)) )
st_width.text =  String( Long(UnitsToPixels(ll_logo_width, XUnitsToPixels!)) )

st_zoom.text = String(Int((p_1.width/ll_logo_width) * 100)) + '%'
gb_preview.text = 'Preview ( Zoom: '+st_zoom.text+' )'
li_size = Int(FileLength(as_file)/1024)
If li_size = 0 Then li_size = 1
st_size.text =String(li_size,'###,###,###') + ' KB'
p_1.Setredraw( True )
//This.SetRedraw(True)
Return 1
end function

public function integer of_reset ();st_height.text =  ''
st_width.text =  ''
st_zoom.text =''
gb_preview.text = 'Preview '
p_1.picturename = ''
sle_filename.text = ''
mle_desc.text = ''

Return 1
end function

public subroutine of_refresh (boolean ab_refresh_pic);Long ll_id, ll_find
String ls_pfilename

If ib_running Then Return

If dw_picture.GetRow() > 0 Then
	ll_id = dw_picture.GetItemNumber(dw_picture.GetRow(), 'id')
End If

//dw_picture.SetRedraw(False)

//Workaround APB Bug. need reset the dataobject to redraw the b_preview graph.
If ab_refresh_pic Then
	dw_picture.DataObject = dw_picture.DataObject
End If

ls_pfilename = dw_picture.Describe("b_preview.filename")
dw_picture.Modify( "b_preview.filename = ''"  )
dw_picture.Modify( "b_preview.filename = " + ls_pfilename )
dw_picture.SettransObject(SQLCA)
dw_picture.Retrieve()
If ll_id > 0 Then
	ll_find = dw_picture.Find('id = ' + String(ll_id), 1, dw_picture.RowCount())
	If ll_find > 0 Then
		dw_picture.SetRow(ll_find)
		dw_picture.ScrolltoRow(ll_find)
		dw_picture.Event rowfocuschanged(ll_find)
	End If
End If
dw_picture.groupcalc( )
//dw_picture.SetRedraw(True)

end subroutine

public subroutine of_refresh ();of_refresh(False)
end subroutine

on w_picture_painter.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.cb_previewall=create cb_previewall
this.cb_delete=create cb_delete
this.cb_update_pic=create cb_update_pic
this.p_2=create p_2
this.st_4=create st_4
this.sle_filename=create sle_filename
this.st_8=create st_8
this.st_ext=create st_ext
this.st_6=create st_6
this.cb_refresh=create cb_refresh
this.mle_desc=create mle_desc
this.st_size=create st_size
this.st_zoom=create st_zoom
this.st_width=create st_width
this.st_height=create st_height
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_5=create st_5
this.p_1=create p_1
this.dw_picture=create dw_picture
this.cb_stop=create cb_stop
this.hpb_progress=create hpb_progress
this.st_progress=create st_progress
this.cb_import_pic=create cb_import_pic
this.cb_close=create cb_close
this.cb_save=create cb_save
this.gb_2=create gb_2
this.gb_preview=create gb_preview
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.cb_previewall
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_update_pic
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.sle_filename
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.st_ext
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.cb_refresh
this.Control[iCurrent+12]=this.mle_desc
this.Control[iCurrent+13]=this.st_size
this.Control[iCurrent+14]=this.st_zoom
this.Control[iCurrent+15]=this.st_width
this.Control[iCurrent+16]=this.st_height
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.st_5
this.Control[iCurrent+21]=this.p_1
this.Control[iCurrent+22]=this.dw_picture
this.Control[iCurrent+23]=this.cb_stop
this.Control[iCurrent+24]=this.hpb_progress
this.Control[iCurrent+25]=this.st_progress
this.Control[iCurrent+26]=this.cb_import_pic
this.Control[iCurrent+27]=this.cb_close
this.Control[iCurrent+28]=this.cb_save
this.Control[iCurrent+29]=this.gb_2
this.Control[iCurrent+30]=this.gb_preview
this.Control[iCurrent+31]=this.gb_4
end on

on w_picture_painter.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.cb_previewall)
destroy(this.cb_delete)
destroy(this.cb_update_pic)
destroy(this.p_2)
destroy(this.st_4)
destroy(this.sle_filename)
destroy(this.st_8)
destroy(this.st_ext)
destroy(this.st_6)
destroy(this.cb_refresh)
destroy(this.mle_desc)
destroy(this.st_size)
destroy(this.st_zoom)
destroy(this.st_width)
destroy(this.st_height)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.p_1)
destroy(this.dw_picture)
destroy(this.cb_stop)
destroy(this.hpb_progress)
destroy(this.st_progress)
destroy(this.cb_import_pic)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.gb_2)
destroy(this.gb_preview)
destroy(this.gb_4)
end on

event open;call super::open;If isvalid(Message.powerobjectparm) Then
	istr_picture = Message.powerobjectparm
	If lower(istr_picture.as_type ) = 'select' Then
		ib_select_mode = True
	End If
	If istr_picture.al_pic_id > 0 Then
		il_default_id =  istr_picture.al_pic_id 
	End If
End If

ll_picture_control_org_width = p_1.width
ll_picture_control_org_height = p_1.height

If ib_select_mode Then
	cb_select.visible = True
	This.Title = 'Choose Picture '
Else
	cb_select.visible = False
End If

Choose Case w_mdi.of_security_access( 6987 ) 
	Case 0 ,1
		cb_save.visible = False
		//cb_select.x = cb_refresh.x   //Start Code Change ----07.23.2014 #V14.2 maha - removed
		//cb_refresh.x = cb_save.x //Start Code Change ----07.23.2014 #V14.2 maha - removed
		cb_import_pic.visible = False  //Start Code Change ----07.23.2014 #V14.2 maha - changed property to visible
		cb_update_pic.visible = False   //Start Code Change ----07.23.2014 #V14.2 maha - changed property to visible
		cb_delete.visible = False   //Start Code Change ----07.23.2014 #V14.2 maha - changed property to visible
	Case 2
		cb_save.visible = True		
End Choose
	


end event

event pfc_save;call super::pfc_save;If cb_save.event clicked( ) > 0 Then
	Return 0
Else
	Return 1
End If
end event

event pfc_postopen;call super::pfc_postopen;dw_picture.SetTransObject(SQLCA)
dw_picture.Retrieve()

if dw_picture.rowcount() = 0 then  //Start Code Change ----07.17.2014 #V14.2 maha
	string s
	s = "To be able to to select pictures, they must first be imported.  Click the Import Picture(s) button.~r" 
	s+= "Select the picture files you wish to import (there are dozens of them in the IntelliCred folder).  ~rYou can multi-select by pressing the control key while clicking with the mouse.  ~rClick Open and the pictures will be imported." 
	messagebox("Picture select",s)
end if

If cb_save.enabled = False or cb_save.visible = False Then
	sle_filename.displayonly = True
	mle_desc.displayonly = True
	sle_filename.backcolor = gb_4.backcolor
	mle_desc.backcolor = gb_4.backcolor
	//Start Code Change ----07.17.2014 #V14.2 maha - added
	st_height.backcolor = gb_4.backcolor
	st_width.backcolor = gb_4.backcolor
	st_ext.backcolor = gb_4.backcolor
	st_size.backcolor = gb_4.backcolor
	//End Code Change ----07.17.2014 
	dw_picture.of_setupdateable( False )
End If

Long ll_find
If il_default_id > 0 Then
	ll_find =  dw_picture.Find(' id = ' + String(il_default_id), 1, dw_picture.RowCount() )  
	If ll_find > 0 Then
		dw_picture.SetRow(ll_find)
		dw_picture.ScrollToRow (ll_find)
	End If
End If
end event

type cb_select from commandbutton within w_picture_painter
integer x = 3045
integer y = 32
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Se&lect"
end type

event clicked;Long ll_id
String ls_file

If ib_running Then Return

If dw_picture.GetRow() <= 0 Then Return 0

ll_id = dw_picture.GetItemNumber(dw_picture.GetRow(), 'id' )

If inv_utils.of_download_picture( ll_id, ls_file ) > 0 Then
	If FileExists(ls_file) Then
		istr_picture.al_pic_id = ll_id
		istr_picture.as_pic_file = ls_file
	Else
		Return
	End If
End If

CloseWithReturn(Parent, istr_picture)

Return


end event

type cb_previewall from commandbutton within w_picture_painter
integer x = 1289
integer y = 32
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Preview All"
end type

event clicked;Long ll_id,  i
String ls_file

If ib_running Then Return

cb_stop.enabled = True
cb_stop.weight = 700
For i = 1 to dw_picture.RowCount()
	ib_running = True
	Yield()
	SetPointer(HourGlass!)
	If Not isvalid(This) Then Return
	If ib_stop Then Exit
	st_progress.text = String(i) + '/' + String(dw_picture.RowCount())
	ll_id = dw_picture.GetItemNumber(i, 'id')
	If inv_utils.of_download_picture( ll_id, ls_file ) > 0 Then
		dw_picture.SetRow(i)
		dw_picture.ScrollToRow(i)
		dw_picture.Selectrow( 0, False)
		dw_picture.Selectrow( i, True)
	End If
Next
ib_running = False
If Not isvalid(Parent) Then Return
ib_stop = False
dw_picture.SetRedraw(False)
cb_refresh.event clicked( )
dw_picture.SetRedraw(True)
cb_stop.enabled = False
cb_stop.weight = 400
SetPointer(Arrow!)
end event

type cb_delete from commandbutton within w_picture_painter
integer x = 571
integer y = 32
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;Long ll_id, ll_tabpage_used, ll_tdl_used, ll_ezmenu_pic_count
String ls_id

If ib_running Then Return

If dw_picture.GetRow() <= 0 then Return

ll_id = dw_picture.GetItemNumber(dw_picture.GetRow(), 'id')

ls_id = String(ll_id)

gnv_appeondb.of_startqueue( )
	Select Count(1) into :ll_tabpage_used from ctx_tabpage_properties Where tab_icon = :ls_id;
	Select Count(1) into :ll_tdl_used from tdl_detail Where tv_icon = :ls_id;
	Select Count(1) into :ll_ezmenu_pic_count from security_viewid_options 
	where view_id = 1001 and  left(option_name,6) = 'EZMENU'  and  right(option_name,4 ) = 'ICON' and option_value = :ls_id;
gnv_appeondb.of_commitqueue( )

If ll_tabpage_used > 0 Then
	Messagebox('Delete','It cannot be deleted because it is being used by the Tab Page.',Exclamation!)
	Return
End If
If ll_tdl_used > 0 Then
	Messagebox('Delete','It cannot be deleted because it is being used by the To Do List.',Exclamation!)
	Return
End If
If ll_ezmenu_pic_count > 0 Then
	Messagebox('Delete','It cannot be deleted because it is being used by the EZ Menu.',Exclamation!)
	Return
End If
If messagebox('Delete','Do you want to delete this picture (ID='+String(ll_id)+')?' , Question!, Yesno!) = 1 Then
	dw_picture.DeleteRow(dw_picture.GetRow())
	dw_picture.event rowfocuschanged(dw_picture.GetRow())
End If


end event

type cb_update_pic from commandbutton within w_picture_painter
integer x = 3305
integer y = 780
integer width = 411
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update Picture..."
end type

event clicked;// 03/14/12 Added By mark added batch import documents of log 
string ls_FilePath
string ls_FileName
string ls_FileFullName
integer i, li_FileCount
integer li_Return
long ll_CurrentRow
long ll_bidq_doc_id
blob lblb_Data
boolean lb_ConvertPDF
long 	ll_ctx_id	 , ll_imported_filecont	// 03/08/12 Added By mark 
string 	ls_msg, ls_error
Long ll_picture_id

If ib_running Then Return

If dw_picture.GetRow() <= 0 Then Return

ll_picture_id = dw_picture.GetItemNumber(dw_picture.GetRow(), 'id')
If isnull(ll_picture_id) Then
	Messagebox('Update','Please save data first.')
	Return 0
End If

// Select import files
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
//li_Return = GetFileOpenName("Select File", &
//		+ ls_FilePath, ls_FileName, "BMP", &
//		+ "BMP Files (*.BMP),*.BMP," &
//		+ "GIF Files (*.GIF),*.GIF," &
//		+ "JPG Files (*.JPG),*.JPG " )
li_Return = GetFileOpenName("Select File", &
		+ ls_FilePath, ls_FileName,"bmp","Graphic Files (*.bmp;*.gif;*.jpg;*.jpeg),*.bmp;*.gif;*.jpg;*.jpeg" )			
		
gf_save_dir_path(ls_FilePath) //Added by Ken.Guo on 2009-03-10

if li_Return <> 1 then Return

// set default the values
gb_recordlog = true

// Upload import files to database
SetPointer(HourGlass!)

ls_FileFullName = ls_FilePath

If of_upload_picture(ls_FileFullName, ll_picture_id, ls_error) = -1 then
	SetPointer(Arrow!)
	gb_recordlog = false
	MessageBox("Import Result","Failed to update picture." ,Exclamation! ) 
	Return -1
End If

SetPointer(Arrow!)
// clear the variables the values
gb_recordlog = false
st_progress.Text = 'Completed!'

gnv_data.of_retrieve('ctx_pictures')

//dw_picture.event rowfocuschanged( dw_picture.GetRow() )
dw_picture.SetRedraw(False)
cb_refresh.event clicked( )
dw_picture.SetRedraw(True)
// Prompt message setting
MessageBox("Update Result","Update picture successfully.")

end event

type p_2 from picture within w_picture_painter
boolean visible = false
integer x = 928
integer y = 2144
integer width = 256
integer height = 216
boolean originalsize = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_picture_painter
integer x = 3305
integer y = 1348
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
string text = "Description:"
boolean focusrectangle = false
end type

type sle_filename from singlelineedit within w_picture_painter
event ue_modified pbm_enchange
integer x = 3301
integer y = 1220
integer width = 1198
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_modified;This.event modified( )
end event

event modified;If dw_picture.GetRow() > 0 Then
	If dw_picture.GetItemString(dw_picture.GetRow(), 'file_name') = This.Text Then Return
	dw_picture.SetItem(dw_picture.GetRow(), 'file_name', This.Text )
End If
end event

type st_8 from statictext within w_picture_painter
integer x = 3931
integer y = 928
integer width = 183
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Ext:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_ext from statictext within w_picture_painter
integer x = 4137
integer y = 924
integer width = 261
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_picture_painter
integer x = 3305
integer y = 1152
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
string text = "File Name:"
boolean focusrectangle = false
end type

type cb_refresh from commandbutton within w_picture_painter
integer x = 3502
integer y = 32
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;of_refresh(True)
//Long ll_id, ll_find
//
//If ib_running Then Return
//
//If dw_picture.GetRow() > 0 Then
//	ll_id = dw_picture.GetItemNumber(dw_picture.GetRow(), 'id')
//End If
//
////dw_picture.SetRedraw(False)
////dw_picture.DataObject = dw_picture.DataObject
//String ls_pfilename
//ls_pfilename = dw_picture.Describe("b_preview.filename")
//dw_picture.Modify( "b_preview.filename = ''"  )
//dw_picture.Modify( "b_preview.filename = " + ls_pfilename )
//dw_picture.SettransObject(SQLCA)
//dw_picture.Retrieve()
//If ll_id > 0 Then
//	ll_find = dw_picture.Find('id = ' + String(ll_id), 1, dw_picture.RowCount())
//	If ll_find > 0 Then
//		dw_picture.SetRow(ll_find)
//		dw_picture.ScrolltoRow(ll_find)
//		dw_picture.Event rowfocuschanged(ll_find)
//	End If
//End If
//dw_picture.groupcalc( )
////dw_picture.SetRedraw(True)
//
end event

type mle_desc from multilineedit within w_picture_painter
event ue_modified pbm_enchange
integer x = 3301
integer y = 1420
integer width = 1198
integer height = 492
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_modified;This.event modified( )
end event

event modified;If dw_picture.GetRow() > 0 Then
	If dw_picture.GetItemString(dw_picture.GetRow(), 'description') = This.Text Then Return
	dw_picture.SetItem(dw_picture.GetRow(), 'description', This.Text )
End If
end event

type st_size from statictext within w_picture_painter
integer x = 4137
integer y = 1028
integer width = 261
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type st_zoom from statictext within w_picture_painter
boolean visible = false
integer x = 2057
integer y = 2132
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type st_width from statictext within w_picture_painter
integer x = 3520
integer y = 1024
integer width = 261
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type st_height from statictext within w_picture_painter
integer x = 3520
integer y = 924
integer width = 261
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within w_picture_painter
integer x = 3931
integer y = 1032
integer width = 183
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Size:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_picture_painter
boolean visible = false
integer x = 1851
integer y = 2132
integer width = 183
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zoom:"
alignment alignment = right!
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_picture_painter
integer x = 3314
integer y = 1028
integer width = 183
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Width:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_picture_painter
integer x = 3314
integer y = 928
integer width = 183
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Height:"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_1 from picture within w_picture_painter
integer x = 3314
integer y = 320
integer width = 1170
integer height = 404
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_picture from u_dw within w_picture_painter
integer x = 91
integer y = 248
integer width = 3045
integer height = 1660
integer taborder = 10
string dataobject = "d_picture_list"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_file
Long ll_id

If GetRow() <= 0 Then 
	of_reset()
	Return
End If
ll_id = This.GetItemNumber(GetRow(), 'id')

inv_utils.of_download_picture( ll_id, ls_file )

p_1.picturename = ''
st_height.text = ''
st_width.text = ''
st_zoom.text = ''
st_size.text = ''
gb_preview.text = 'Preview'

sle_filename.text = This.GetItemString(GetRow(), 'File_name')
st_ext.text = This.GetItemString(GetRow(), 'File_ext')
mle_desc.text = This.GetItemString(GetRow(), 'Description')
If FileExists(ls_file) Then
	Parent.of_preview_file( ls_file )	
End If

//String ls_pfilename
//ls_pfilename = This.Describe("b_preview.filename")
//This.SetRedraw(False)
//This.Modify( "b_preview.filename = ''"  )
//This.Modify( "b_preview.filename = " + ls_pfilename )
//This.SetRedraw(True)
end event

event constructor;call super::constructor;This.of_setrowselect( True )
This.of_setrowmanager( True )

this.of_SetSort(true)
This.inv_sort.of_SetColumnHeader(true)

end event

type cb_stop from commandbutton within w_picture_painter
integer x = 933
integer y = 32
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "St&op"
end type

event clicked;ib_stop = True
end event

type hpb_progress from hprogressbar within w_picture_painter
integer x = 1065
integer y = 2052
integer width = 1019
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 10
integer setstep = 10
end type

type st_progress from statictext within w_picture_painter
integer x = 1728
integer y = 48
integer width = 978
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean border = true
boolean focusrectangle = false
end type

type cb_import_pic from commandbutton within w_picture_painter
integer x = 91
integer y = 32
integer width = 462
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Import Picture(s)..."
end type

event clicked;// 03/14/12 Added By mark added batch import documents of log 
string ls_FilePath
string ls_FileName[]
string ls_FileFullName
integer i, li_FileCount
integer li_Return
long ll_CurrentRow
long ll_bidq_doc_id, ll_rowcount
blob lblb_Data
boolean lb_ConvertPDF
long 	ll_ctx_id	 , ll_imported_filecont	// 03/08/12 Added By mark 
string 	ls_msg, ls_error
Long ll_picture_id

If ib_running Then Return

// Select import files
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
//li_Return = GetFileOpenName("Select File(s)", &
//		+ ls_FilePath, ls_FileName[], "BMP", &
//		+ "BMP Files (*.BMP),*.BMP," &
//		+ "GIF Files (*.GIF),*.GIF," &
//		+ "JPG Files (*.JPG),*.JPG " )
		
li_Return = GetFileOpenName("Select File(s)", &
		+ ls_FilePath, ls_FileName[],"bmp","Graphic Files (*.bmp;*.gif;*.jpg;*.jpeg),*.bmp;*.gif;*.jpg;*.jpeg" )		
gf_save_dir_path(ls_FilePath) //Added by Ken.Guo on 2009-03-10

if li_Return <> 1 then Return

li_FileCount = UpperBound(ls_FileName[])

// set default the values
gb_recordlog = true
st_progress.Text = 'Select File...'
hpb_progress.Maxposition = li_FileCount
hpb_progress.Position = 0
cb_stop.enabled = true	
cb_stop.weight = 700
il_count	= 0
ll_imported_filecont = 0 
// Upload import files to database
SetPointer(HourGlass!)

ll_picture_id = gnv_app.of_get_id( 'picture_id', li_FileCount)
If ll_picture_id <= 0 or isnull(ll_picture_id) Then 
	Messagebox('Error 1','Failed to get id value.')
	Return -1
End If

ll_imported_filecont = 0
for i = 1 to li_FileCount	
	
	ib_running = True
	//stop executing the process 
	yield()
	if ib_stop = true then 
		//ll_imported_filecont = i - 1
		exit
	end if 

	if li_FileCount > 1 then
		ls_FileFullName = ls_FilePath + "\" + ls_FileName[i]
	else
		ls_FileFullName = ls_FilePath
	end if

	If of_upload_picture(ls_FileFullName, ll_picture_id + i - 1, ls_error) = -1 then
		continue
	else
	end if
	st_progress.Text = 'Import Picture(s) '+string( Int( i / li_FileCount * 100) )+'%'
	hpb_progress.Position = i
	ll_imported_filecont ++
next

gnv_data.of_retrieve('ctx_pictures')

SetPointer(Arrow!)
// clear the variables the values
gb_recordlog = false
If ib_stop Then
	st_progress.Text = 'Stoped!'
Else
	st_progress.Text = 'Completed!'
End If
hpb_progress.Position = 0
cb_stop.enabled = false
cb_stop.weight = 400
ib_stop = false
ib_running = False

dw_picture.SetRedraw(False)
//cb_refresh.event clicked( )
of_refresh()
ll_rowcount = dw_picture.RowCount()
If ll_rowcount > 0 Then 
	dw_picture.SetRow(ll_rowcount)
	dw_picture.ScrollToRow(ll_rowcount)
	dw_picture.event rowfocuschanged( ll_rowcount )
End If
dw_picture.SetRedraw(True)
// Prompt message setting
ls_msg = "Import of "+string(ll_imported_filecont)+" picture(s) completed. "
If ll_imported_filecont = li_FileCount  Then 
	MessageBox("Import Result",ls_msg , Information!,OK! ) 
Else
	ls_msg 	+= "~r~n~r~n" + string(ll_imported_filecont )+" Success ~r~n"+ &
					string(li_FileCount - ll_imported_filecont)+" Failure~r~n~r~n"
	MessageBox("Import Result",ls_msg,Exclamation!) 
End if 

end event

type cb_close from commandbutton within w_picture_painter
integer x = 4206
integer y = 32
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;If ib_running Then Return

CloseWithReturn(Parent, istr_null )

end event

type cb_save from commandbutton within w_picture_painter
integer x = 3854
integer y = 32
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;Long ll_row
String ls_filename, ls_desc

If ib_running Then Return

ll_row = dw_picture.GetRow()

If ll_row > 0 Then
	ls_filename = dw_picture.GetItemString(ll_row, 'file_name')
	ls_desc = dw_picture.GetItemString(ll_row, 'description')
	If isnull(ls_filename) Then ls_filename  = ''
	If isnull(ls_desc) Then ls_desc  = ''
	If sle_filename.text <> ls_desc Then
		dw_picture.SetItem(ll_row, 'file_name' , sle_filename.text )
	End If
	If mle_desc.text <> ls_desc Then
		dw_picture.SetItem(ll_row, 'description' , mle_desc.text )
	End If	
	If dw_picture.Modifiedcount( )  + dw_picture.Deletedcount( ) > 0 Then
		If dw_picture.Update() = 1 Then
			gnv_data.of_retrieve('ctx_pictures')
			Messagebox('Save','Save data successfully.')
		Else
			Messagebox('Save','Failed to save data, please refresh data then try again.',Exclamation! )
		End If
	End If
End If


end event

type gb_2 from groupbox within w_picture_painter
integer x = 50
integer y = 184
integer width = 3127
integer height = 1772
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Pictures"
end type

type gb_preview from groupbox within w_picture_painter
integer x = 3264
integer y = 260
integer width = 1257
integer height = 496
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Preview ( Zoom: 100% )"
end type

type gb_4 from groupbox within w_picture_painter
integer x = 3227
integer y = 184
integer width = 1339
integer height = 1772
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Properties"
end type

