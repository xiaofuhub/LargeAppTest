$PBExportHeader$w_bitmap_test.srw
forward
global type w_bitmap_test from window
end type
type p_picture from picture within w_bitmap_test
end type
type rb_clipboard from radiobutton within w_bitmap_test
end type
type rb_file from radiobutton within w_bitmap_test
end type
type cb_capture_window from commandbutton within w_bitmap_test
end type
type cb_capture_control from commandbutton within w_bitmap_test
end type
type cb_capture_screen from commandbutton within w_bitmap_test
end type
type cb_close from commandbutton within w_bitmap_test
end type
end forward

global type w_bitmap_test from window
integer width = 1682
integer height = 1092
boolean titlebar = true
string title = "Capture Screen to Bitmap file"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
p_picture p_picture
rb_clipboard rb_clipboard
rb_file rb_file
cb_capture_window cb_capture_window
cb_capture_control cb_capture_control
cb_capture_screen cb_capture_screen
cb_close cb_close
end type
global w_bitmap_test w_bitmap_test

type variables
n_bitmap in_bitmap
n_runandwait in_runandwait
String is_tempdir

end variables

on w_bitmap_test.create
this.p_picture=create p_picture
this.rb_clipboard=create rb_clipboard
this.rb_file=create rb_file
this.cb_capture_window=create cb_capture_window
this.cb_capture_control=create cb_capture_control
this.cb_capture_screen=create cb_capture_screen
this.cb_close=create cb_close
this.Control[]={this.p_picture,&
this.rb_clipboard,&
this.rb_file,&
this.cb_capture_window,&
this.cb_capture_control,&
this.cb_capture_screen,&
this.cb_close}
end on

on w_bitmap_test.destroy
destroy(this.p_picture)
destroy(this.rb_clipboard)
destroy(this.rb_file)
destroy(this.cb_capture_window)
destroy(this.cb_capture_control)
destroy(this.cb_capture_screen)
destroy(this.cb_close)
end on

event open;// get temporary directory
is_tempdir = in_bitmap.of_GetTempPath()

end event

type p_picture from picture within w_bitmap_test
integer x = 841
integer y = 160
integer width = 736
integer height = 644
string picturename = "Custom026!"
boolean focusrectangle = false
boolean map3dcolors = true
end type

type rb_clipboard from radiobutton within w_bitmap_test
integer x = 841
integer y = 32
integer width = 731
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Save bitmap to clipboard"
end type

type rb_file from radiobutton within w_bitmap_test
integer x = 37
integer y = 32
integer width = 773
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Write to file and open in editor"
boolean checked = true
end type

type cb_capture_window from commandbutton within w_bitmap_test
integer x = 37
integer y = 672
integer width = 699
integer height = 132
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Capture Entire Window"
end type

event clicked;String ls_fname
Blob lblb_bitmap

SetPointer(HourGlass!)

ls_fname = is_tempdir + "window.bmp"

If rb_clipboard.Checked Then
	lblb_bitmap = in_bitmap.of_WindowCapture(Parent, True)
Else
	lblb_bitmap = in_bitmap.of_WindowCapture(Parent, False)
	in_bitmap.of_WriteBlob(ls_fname, lblb_bitmap)
	in_runandwait.of_ShellRun(ls_fname, "Open", Maximized!)
	FileDelete(ls_fname)
End If

end event

type cb_capture_control from commandbutton within w_bitmap_test
integer x = 37
integer y = 416
integer width = 699
integer height = 132
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Capture Picture Control -->"
end type

event clicked;String ls_fname
Blob lblb_bitmap

SetPointer(HourGlass!)

ls_fname = is_tempdir + "control.bmp"

If rb_clipboard.Checked Then
	lblb_bitmap = in_bitmap.of_ControlCapture(p_picture, True)
Else
	lblb_bitmap = in_bitmap.of_ControlCapture(p_picture, False)
	in_bitmap.of_WriteBlob(ls_fname, lblb_bitmap)
	in_runandwait.of_ShellRun(ls_fname, "Open", Maximized!)
	FileDelete(ls_fname)
End If

end event

type cb_capture_screen from commandbutton within w_bitmap_test
integer x = 37
integer y = 160
integer width = 699
integer height = 132
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Capture Entire Screen"
end type

event clicked;String ls_fname
Blob lblb_bitmap

SetPointer(HourGlass!)

ls_fname = is_tempdir + "screen.bmp"

If rb_clipboard.Checked Then
	lblb_bitmap = in_bitmap.of_ScreenCapture(True)
Else
	lblb_bitmap = in_bitmap.of_ScreenCapture(False)
	in_bitmap.of_WriteBlob(ls_fname, lblb_bitmap)
	in_runandwait.of_ShellRun(ls_fname, "Open", Maximized!)
	FileDelete(ls_fname)
End If

end event

type cb_close from commandbutton within w_bitmap_test
integer x = 1243
integer y = 832
integer width = 334
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

