$PBExportHeader$w_append_pages.srw
forward
global type w_append_pages from window
end type
type rb_fromfile from radiobutton within w_append_pages
end type
type rb_fromscanner from radiobutton within w_append_pages
end type
type rb_fromblank from radiobutton within w_append_pages
end type
type ole_admin from olecustomcontrol within w_append_pages
end type
type cb_cancel from commandbutton within w_append_pages
end type
type cb_ok from commandbutton within w_append_pages
end type
type em_1 from editmask within w_append_pages
end type
type rb_beforepage from radiobutton within w_append_pages
end type
type rb_atend from radiobutton within w_append_pages
end type
type gb_1 from groupbox within w_append_pages
end type
type gb_2 from groupbox within w_append_pages
end type
end forward

global type w_append_pages from window
integer width = 1070
integer height = 824
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_fromfile rb_fromfile
rb_fromscanner rb_fromscanner
rb_fromblank rb_fromblank
ole_admin ole_admin
cb_cancel cb_cancel
cb_ok cb_ok
em_1 em_1
rb_beforepage rb_beforepage
rb_atend rb_atend
gb_1 gb_1
gb_2 gb_2
end type
global w_append_pages w_append_pages

type variables
string is_from_method//ls_from_method//method. 0:from file, 1:from scanner, 2:from blank page.
string is_append_method//ls_append_method//append. 0/0: at the end, 1/x: before page.
long il_page_count//li_page_count
string is_app_path
Boolean ib_from_application = False //Application Mapping Flag, Added by Appeon long.zhang 11.09.2016 
end variables

on w_append_pages.create
this.rb_fromfile=create rb_fromfile
this.rb_fromscanner=create rb_fromscanner
this.rb_fromblank=create rb_fromblank
this.ole_admin=create ole_admin
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.em_1=create em_1
this.rb_beforepage=create rb_beforepage
this.rb_atend=create rb_atend
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.rb_fromfile,&
this.rb_fromscanner,&
this.rb_fromblank,&
this.ole_admin,&
this.cb_cancel,&
this.cb_ok,&
this.em_1,&
this.rb_beforepage,&
this.rb_atend,&
this.gb_1,&
this.gb_2}
end on

on w_append_pages.destroy
destroy(this.rb_fromfile)
destroy(this.rb_fromscanner)
destroy(this.rb_fromblank)
destroy(this.ole_admin)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.em_1)
destroy(this.rb_beforepage)
destroy(this.rb_atend)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;//--------------------------APPEON BEGIN -------------------------
//$<Modify> long.zhang 10.13.2011
//$<Reason> can be shared with Append Existing image function

//is_app_path=message.stringparm
Constant Integer control_pos =200

if posA(message.stringparm,"*") > 0 then
		is_app_path=MidA(message.stringparm,2)
		
		rb_fromblank.automatic = false
		rb_fromblank.checked = false
		
		rb_fromscanner.checked = false
		rb_fromscanner.automatic = false
		
		rb_fromfile.checked=true
		
		gb_1.visible =  false
		rb_fromblank.visible = false
		rb_fromfile.visible = false
		rb_fromscanner.visible = false
		gb_1.y -=control_pos

		gb_2.y -= control_pos
		rb_atend.y -= control_pos
		rb_beforepage.y -= control_pos
		em_1.y -= control_pos
		cb_ok.y -= control_pos
		cb_cancel.y -= control_pos
else
	ib_from_application = True //Added by Appeon long.zhang 11.09.2016 
		is_app_path=message.stringparm	
end if
//----------------------APPEON END--------------------------------
end event

type rb_fromfile from radiobutton within w_append_pages
integer x = 562
integer y = 104
integer width = 425
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Existing Pages"
end type

type rb_fromscanner from radiobutton within w_append_pages
integer x = 69
integer y = 208
integer width = 485
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Acquire Image"
end type

type rb_fromblank from radiobutton within w_append_pages
integer x = 69
integer y = 104
integer width = 603
integer height = 64
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Blank Page"
boolean checked = true
end type

type ole_admin from olecustomcontrol within w_append_pages
event filepropertiesclose ( )
integer x = 978
integer y = 672
integer width = 155
integer height = 136
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_append_pages.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_cancel from commandbutton within w_append_pages
integer x = 517
integer y = 704
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent,'Cancel')

end event

type cb_ok from commandbutton within w_append_pages
integer x = 174
integer y = 704
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;String ls_ext = 'TIF' //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)

IF rb_fromfile.Checked THEN
	is_from_method = '0'
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 11.09.2016
	//<$>reason:add back '*' into the message, for Bug ID #5397 for Case # 00067601: IS issue 110716	
	//OpenWithParm(w_get_image_from_file,is_app_path)
	If ib_from_application Then
		OpenWithParm(w_get_image_from_file, is_app_path)
	Else
		OpenWithParm(w_get_image_from_file,'*'+ is_app_path)
	End If
	//------------------- APPEON END -------------------
	
	IF Message.StringParm = "Cancel" THEN
		RETURN -1
	ELSE  //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
		ls_ext = UPPER(Message.StringParm)
	END IF
ELSEIF rb_fromscanner.Checked THEN
	is_from_method = '1'
	IF IsValid(w_train_app) THEN
		w_train_app.ib_insert_scan = true //add by stephen 02.13.2012 -- Bug 2912: can not append pages from the scanner
		IF w_train_app.of_scan_insert() = 1 THEN
			ole_admin.Object.Image( is_app_path+ "scanappend.tif" )
			il_page_count = ole_admin.Object.PageCount()
		ELSE
			RETURN -1
		END IF
	END IF
ELSEIF rb_fromblank.Checked THEN
	is_from_method = '2'
	il_page_count = 1
END IF

IF rb_atend.Checked THEN
	is_append_method = '0/0'
ELSEIF rb_beforepage.Checked THEN
	is_append_method = '1/'+String(em_1.Text)
END IF

If ib_from_application Then //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
	CloseWithReturn(Parent,is_from_method+'-'+is_append_method+'\'+String(il_page_count))
ELSE
	CloseWithReturn(Parent,is_from_method+'-'+is_append_method+'\'+String(il_page_count)+'\'+ls_ext)
END IF








end event

type em_1 from editmask within w_append_pages
integer x = 453
integer y = 548
integer width = 224
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
string text = "1"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1~~"
boolean usecodetable = true
end type

event losefocus;IF Long(Trim(This.Text)) <= 0 THEN
	MessageBox("Warning","This Value must be greater than Zero. ")
	This.SetFocus()
	This.SelectText(1, LenA(This.Text))
END IF

end event

type rb_beforepage from radiobutton within w_append_pages
integer x = 69
integer y = 556
integer width = 416
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Before Page"
end type

event clicked;if this.checked then
	em_1.enabled=true
end if
end event

type rb_atend from radiobutton within w_append_pages
integer x = 69
integer y = 452
integer width = 713
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "At the End"
boolean checked = true
end type

event clicked;if this.checked then
	em_1.enabled=false
end if
end event

type gb_1 from groupbox within w_append_pages
integer x = 32
integer y = 8
integer width = 997
integer height = 332
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Append From"
end type

type gb_2 from groupbox within w_append_pages
integer x = 32
integer y = 356
integer width = 997
integer height = 324
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Position to Insert"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_append_pages.bin 
2600000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000b926c0d001d3680b00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000b926c0d001d3680bb926c0d001d3680b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000300020000038400000384000000000000010000000000000000000000000001010000000000000000000000000000010003000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001000000000200000300000000000300000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_append_pages.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
