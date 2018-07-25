$PBExportHeader$w_pdf_viewer.srw
forward
global type w_pdf_viewer from window
end type
type ole_1 from olecustomcontrol within w_pdf_viewer
end type
type sle_text from singlelineedit within w_pdf_viewer
end type
type cb_annot from commandbutton within w_pdf_viewer
end type
end forward

global type w_pdf_viewer from window
integer width = 3419
integer height = 2444
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ole_1 ole_1
sle_text sle_text
cb_annot cb_annot
end type
global w_pdf_viewer w_pdf_viewer

on w_pdf_viewer.create
this.ole_1=create ole_1
this.sle_text=create sle_text
this.cb_annot=create cb_annot
this.Control[]={this.ole_1,&
this.sle_text,&
this.cb_annot}
end on

on w_pdf_viewer.destroy
destroy(this.ole_1)
destroy(this.sle_text)
destroy(this.cb_annot)
end on

event open;string ls_file

ls_file = "c:\aatest\CAQH first 5 pg.pdf"

ole_1.object.LoadMultiPage(ls_file, 1)
end event

type ole_1 from olecustomcontrol within w_pdf_viewer
event click ( )
event dblclick ( )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event selectionrectdrawn ( long ileft,  long itop,  long iwidth,  long iheight )
event ocrrecognized ( boolean bsuccess )
event dicomplaying ( integer iframeindex )
event ocrpdfa ( integer iprogress )
event loadimagefromurlcompleted ( )
event ocrpdfatextfile ( integer iprogress )
integer x = 46
integer y = 428
integer width = 3278
integer height = 1812
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_pdf_viewer.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event constructor;//This.object.licensekey = '11580'
end event

type sle_text from singlelineedit within w_pdf_viewer
integer x = 41
integer y = 36
integer width = 649
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "Test 1"
borderstyle borderstyle = stylelowered!
end type

type cb_annot from commandbutton within w_pdf_viewer
integer x = 754
integer y = 32
integer width = 430
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add annotation"
end type

event clicked;string ls_text

ls_text = sle_text.text

ole_1.object.drawtext(1, 1,ls_text, true )

ole_1.object.PDFDrawText( '0', 1,1, ls_text , 1,8 , 0)


end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_pdf_viewer.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_pdf_viewer.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
