﻿$PBExportHeader$u_thumb_edit_cp1.sru
forward
global type u_thumb_edit_cp1 from userobject
end type
type ole_edit from olecustomcontrol within u_thumb_edit_cp1
end type
end forward

global type u_thumb_edit_cp1 from userobject
integer width = 1957
integer height = 1292
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
ole_edit ole_edit
end type
global u_thumb_edit_cp1 u_thumb_edit_cp1

type variables
Window iw_parent
end variables

forward prototypes
public function integer of_set_parent (window aw_parent)
public subroutine of_resize ()
end prototypes

public function integer of_set_parent (window aw_parent);//Added by (APPEON) Harry 11.27.2017 (V161 Storage of Documents as PDFs)
iw_parent = aw_parent
Return 1
end function

public subroutine of_resize ();ole_edit.Width = this.Width
ole_edit.Height = this.Height
end subroutine

on u_thumb_edit_cp1.create
this.ole_edit=create ole_edit
this.Control[]={this.ole_edit}
end on

on u_thumb_edit_cp1.destroy
destroy(this.ole_edit)
end on

event constructor;of_resize()
end event

type ole_edit from olecustomcontrol within u_thumb_edit_cp1
event ondropfiles ( integer ifilecount )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event thumbnailvscroll ( long isbcode,  long isbpos )
event thumbnailhscroll ( long isbcode,  long isbpos )
event click ( integer iclipindex,  string strfilepath,  integer ipageno )
event dblclick ( integer iclipindex,  string strfilepath,  integer ipageno )
event rightclick ( integer iclipindex,  string strfilepath,  integer ipageno )
event thumbnailclick ( integer iclipindex,  string strfilepath,  integer ipageno )
event rightpress ( integer iclipindex,  string strfilepath,  integer ipageno )
event leftpress ( integer iclipindex,  string strfilepath,  integer ipageno )
event dragedclip ( )
integer width = 1966
integer height = 1300
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "u_thumb_edit_cp1.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event click(integer iclipindex, string strfilepath, integer ipageno);//Added by (APPEON) Harry 11.06.2017 for Storage of Documents as PDFs
IF ipageno < 1 or isnull(ipageno) THEN return

//ole_edit_pdf.ole_edit.Object.LoadMultiPage( ole_edit_pdf.ole_edit.Object.filename, ipageno)

iw_parent.Dynamic of_thumb_click(ipageno)
end event

event constructor;This.object.licensekey = '12500'
This.object.EnableDragFile = False
This.object.DisplayMode = 0 //0 - Fast Speed, poor Quality        clip size 80x 80 quality
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
03u_thumb_edit_cp1.bin 
2C00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000003000000000000000000000000000000000000000000000000000000006b668b9001d3673000000003000001c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004dc11c60e45674a306905feb92c5e3570000000006b668b9001d367306b668b9001d36730000000000000000000000000fffffffe000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0065004400650076006f006c00650070002000720069006c006500630073006e003a0065006d00690067006100740065007500680063006d00390070003900390000fffe00020106dc11c60e45674a306905feb92c5e357000000001fb8f0821101b01640008ed8413c72e2b00000030000000a4000000050000010000000030000001010000003800000102000000400000010300000048000000000000005000000003000100000000000300002c71000000030000219700000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000002c7100002197000000000000010172410500006c6169aa0000000000bfbf00000000ff008080f000ffff6400f0f0080064000000000000000000040101006f6d6544000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000004d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13u_thumb_edit_cp1.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
