$PBExportHeader$w_splah_screen_set.srw
forward
global type w_splah_screen_set from w_response
end type
type cb_reset from commandbutton within w_splah_screen_set
end type
type dw_personal from datawindow within w_splah_screen_set
end type
type st_size from statictext within w_splah_screen_set
end type
type cb_apply from commandbutton within w_splah_screen_set
end type
type st_zoom from statictext within w_splah_screen_set
end type
type st_w from statictext within w_splah_screen_set
end type
type st_h from statictext within w_splah_screen_set
end type
type sle_file from singlelineedit within w_splah_screen_set
end type
type cb_cancel from commandbutton within w_splah_screen_set
end type
type cb_ok from commandbutton within w_splah_screen_set
end type
type cb_browse from commandbutton within w_splah_screen_set
end type
type st_3 from statictext within w_splah_screen_set
end type
type gb_1 from groupbox within w_splah_screen_set
end type
type gb_4 from groupbox within w_splah_screen_set
end type
type st_border from statictext within w_splah_screen_set
end type
type p_preview from picture within w_splah_screen_set
end type
end forward

global type w_splah_screen_set from w_response
integer width = 2011
integer height = 1448
string title = "Splash Screen Pic Settings"
long backcolor = 33551856
cb_reset cb_reset
dw_personal dw_personal
st_size st_size
cb_apply cb_apply
st_zoom st_zoom
st_w st_w
st_h st_h
sle_file sle_file
cb_cancel cb_cancel
cb_ok cb_ok
cb_browse cb_browse
st_3 st_3
gb_1 gb_1
gb_4 gb_4
st_border st_border
p_preview p_preview
end type
global w_splah_screen_set w_splah_screen_set

type variables
Long il_bg_color_org
String is_file_path,is_file_name,is_file_ext
Long il_file_lenght
Long il_logo_org_height,il_logo_org_width
n_cst_filesrvwin32 inv_FileSrv

Boolean ib_modify=false
end variables

forward prototypes
public subroutine of_preview_logo (string ls_file_name, ref long al_logo_height, ref long al_logo_width)
public subroutine of_preview_pic (blob lb_file, ref long al_logo_height, ref long al_logo_width)
end prototypes

public subroutine of_preview_logo (string ls_file_name, ref long al_logo_height, ref long al_logo_width);Integer li_size
p_preview.originalsize = True
p_preview.picturename = ls_file_name
al_logo_width = p_preview.width
al_logo_height = p_preview.height

il_logo_org_height= p_preview.height
il_logo_org_width= p_preview.width

If al_logo_width > 1408 Then
	p_preview.width = 1408
	p_preview.height = al_logo_height * (p_preview.width/al_logo_width)
	p_preview.originalsize = False
End If
If al_logo_height > 876 Then
	p_preview.height = 876
	p_preview.width = al_logo_width * (p_preview.height/al_logo_height)
	p_preview.originalsize = False
End If

st_h.text = 'H: ' + String(al_logo_height) 
st_w.text = 'W: ' + String(al_logo_width) 
st_zoom.text = 'Zoom: ' + String(Int((p_preview.width/al_logo_width) * 100)) + '%'
li_size = Int(FileLength(ls_file_name)/1024)
If li_size = 0 Then li_size = 1
st_size.text = 'Size: ' + String(li_size,'###,###,###') + ' KB'

end subroutine

public subroutine of_preview_pic (blob lb_file, ref long al_logo_height, ref long al_logo_width);
String ls_file_ext,ls_logo_file
Long ll_height,ll_width,li_size
IF Not IsNull(lb_file) THEN
	p_preview.SetPicture(lb_file)
	p_preview.OriginalSize = True
	al_logo_width = p_preview.Width
	al_logo_height = p_preview.Height
	
	IF al_logo_width > 1408 THEN
		p_preview.Width = 1408
		p_preview.Height = al_logo_height * (p_preview.Width/al_logo_width)
		p_preview.OriginalSize = False
	END IF
	
	IF al_logo_height > 876 THEN
		p_preview.Height = 876
		p_preview.Width = al_logo_width * (p_preview.Height/al_logo_height)
		p_preview.OriginalSize = False
	END IF
	
	p_preview.SetPicture(lb_file)
	
	st_h.Text = 'H: ' + String(al_logo_height)
	st_w.Text = 'W: ' + String(al_logo_width)
	st_zoom.Text = 'Zoom: ' + String(Int((p_preview.Width/al_logo_width) * 100)) + '%'
	li_size = Long(il_file_lenght/1024)
	IF li_size = 0 THEN li_size = 1
	st_size.Text = 'Size: ' + String(li_size,'###,###,###') + ' KB'
END IF


end subroutine

on w_splah_screen_set.create
int iCurrent
call super::create
this.cb_reset=create cb_reset
this.dw_personal=create dw_personal
this.st_size=create st_size
this.cb_apply=create cb_apply
this.st_zoom=create st_zoom
this.st_w=create st_w
this.st_h=create st_h
this.sle_file=create sle_file
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_browse=create cb_browse
this.st_3=create st_3
this.gb_1=create gb_1
this.gb_4=create gb_4
this.st_border=create st_border
this.p_preview=create p_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reset
this.Control[iCurrent+2]=this.dw_personal
this.Control[iCurrent+3]=this.st_size
this.Control[iCurrent+4]=this.cb_apply
this.Control[iCurrent+5]=this.st_zoom
this.Control[iCurrent+6]=this.st_w
this.Control[iCurrent+7]=this.st_h
this.Control[iCurrent+8]=this.sle_file
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.cb_ok
this.Control[iCurrent+11]=this.cb_browse
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.st_border
this.Control[iCurrent+16]=this.p_preview
end on

on w_splah_screen_set.destroy
call super::destroy
destroy(this.cb_reset)
destroy(this.dw_personal)
destroy(this.st_size)
destroy(this.cb_apply)
destroy(this.st_zoom)
destroy(this.st_w)
destroy(this.st_h)
destroy(this.sle_file)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_browse)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.st_border)
destroy(this.p_preview)
end on

event close;call super::close;If Isvalid(inv_FileSrv) Then Destroy inv_FileSrv
end event

event open;call super::open;Blob  lb_splash_pic
long  ll_org_height,ll_org_width
lb_splash_pic = of_get_pic_fromdb()

of_preview_pic(lb_splash_pic,ll_org_height,ll_org_width)

end event

type cb_reset from commandbutton within w_splah_screen_set
integer x = 37
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reset"
end type

event clicked;Blob lb_file_data
lb_file_data = Blob('0',EncodingAnsi!) //Encoding – Nova 11.16.2010

//--------------- APPEON BEGIN ---------------
//$<modify> 02.05.2009 By: Evan
//$<reason> Fixed a defect
//UpdateBlob ids  Set splash_picture = :lb_file_data;
UpdateBlob ids_image Set splash_picture = :lb_file_data Where id = 1;
//--------------- APPEON END -----------------

IF sqlca.SQLCode <> 0 THEN
	MessageBox("Infor","Splash picture reset unsuccessfully!")
ELSE
	This.Enabled = False
	p_preview.picturename='z:\asdfggas\a.jpg'
	sle_file.text=''
	cb_apply.enabled=false
	p_preview.Width = 1408
	p_preview.Height = 876
	st_h.Text = 'H: '+string(p_preview.Height)
	st_w.text= 'W: '+string(p_preview.Width)
END IF
end event

type dw_personal from datawindow within w_splah_screen_set
boolean visible = false
integer x = 78
integer y = 1460
integer width = 763
integer height = 92
integer taborder = 30
boolean enabled = false
string title = "none"
string dataobject = "d_dashb_settings_auto_open"
boolean border = false
boolean livescroll = true
end type

type st_size from statictext within w_splah_screen_set
integer x = 155
integer y = 704
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Size:"
boolean focusrectangle = false
end type

type cb_apply from commandbutton within w_splah_screen_set
integer x = 1582
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Apply"
end type

event clicked;
Blob lb_file_data
Long ll_FileLen
String ls_new_name
String ls_verify_data
Int li_return
inv_FileSrv = Create n_cst_filesrvwin32

IF il_logo_org_height <> 2400 Or il_logo_org_width <> 3749 THEN
	li_return = MessageBox("Information","The picture may not be correctly displayed if its dimension is not 820*600. ",question!,yesno!,2)
	IF li_return = 2 THEN RETURN 0
	
END IF

IF is_file_path <> '' THEN
	//Save logo to DB
	IF FileExists(is_file_path) THEN
		ll_FileLen = inv_FileSrv.of_FileRead(is_file_path, lb_file_data)
		IF ll_FileLen > 0 THEN
			//--------------- APPEON BEGIN ---------------
			//$<modify> 02.05.2009 By: Evan
			//$<reason> Fixed a defect
			//UpdateBlob ids  Set splash_picture = :lb_file_data;
			UpdateBlob ids_image Set splash_picture = :lb_file_data Where id = 1;
			//--------------- APPEON END -----------------
		END IF
	ELSE
		RETURN 0
	END IF
	
END IF

cb_apply.enabled=false
RETURN 1

end event

type st_zoom from statictext within w_splah_screen_set
integer x = 155
integer y = 612
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Zoom:"
boolean focusrectangle = false
end type

type st_w from statictext within w_splah_screen_set
integer x = 155
integer y = 492
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "W: "
boolean focusrectangle = false
end type

type st_h from statictext within w_splah_screen_set
integer x = 155
integer y = 368
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "H: "
boolean focusrectangle = false
end type

type sle_file from singlelineedit within w_splah_screen_set
integer x = 443
integer y = 92
integer width = 1431
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 134217739
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_splah_screen_set
integer x = 1207
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_splah_screen_set
integer x = 837
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;IF cb_apply.Enabled = True THEN
	IF cb_apply.Trigger Event Clicked() > 0 THEN
		Close(Parent)
	END IF
else
	Close(Parent)
END IF


end event

type cb_browse from commandbutton within w_splah_screen_set
integer x = 101
integer y = 92
integer width = 325
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse..."
end type

event clicked;String ls_logo_path, ls_logo_file
Integer i, li_cnt, li_rtn, li_filenum
Long ll_org_width,ll_org_height

li_rtn = GetFileOpenName("Select Logo File", &
	ls_logo_path, ls_logo_file, "GIF", &
	+ "GIF Files (*.GIF),*.GIF," &
	+ "JPG Files (*.JPG),*.JPG," &
	+ "All Files (*.*), *.*")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF li_rtn < 1 THEN RETURN

//IF Int(FileLength(ls_logo_path)/1024) > 500 THEN
//	MessageBox('Logo',"The logo file's size must less than 500K.")
//	RETURN
//END IF

sle_file.Text = ls_logo_path
Parent.SetRedraw(False)
of_preview_logo(ls_logo_path,ll_org_height,ll_org_width)

cb_apply.enabled=true
cb_reset.enabled=true

il_file_lenght = FileLength(ls_logo_path)
is_file_path = ls_logo_path
is_file_name = ls_logo_file
is_file_ext = RightA(ls_logo_file,3)
il_logo_org_height = ll_org_height
il_logo_org_width = ll_org_width
Parent.SetRedraw(True)





end event

type st_3 from statictext within w_splah_screen_set
integer x = 165
integer y = 204
integer width = 224
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
string text = "Preview:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_splah_screen_set
integer x = 32
integer y = 12
integer width = 1938
integer height = 1188
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Settings"
end type

type gb_4 from groupbox within w_splah_screen_set
boolean visible = false
integer x = 37
integer y = 1388
integer width = 1925
integer height = 196
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Personal Settings"
end type

type st_border from statictext within w_splah_screen_set
integer x = 443
integer y = 212
integer width = 1426
integer height = 888
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type p_preview from picture within w_splah_screen_set
integer x = 453
integer y = 220
integer width = 1408
integer height = 876
boolean bringtotop = true
boolean originalsize = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
boolean map3dcolors = true
end type

event constructor;This.bringtotop = True
end event

