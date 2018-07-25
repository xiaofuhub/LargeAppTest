$PBExportHeader$w_ctx_doc_scan_cp.srw
forward
global type w_ctx_doc_scan_cp from w_response
end type
type st_page from statictext within w_ctx_doc_scan_cp
end type
type pb_next from picturebutton within w_ctx_doc_scan_cp
end type
type pb_prior from picturebutton within w_ctx_doc_scan_cp
end type
type cb_cancel1 from commandbutton within w_ctx_doc_scan_cp
end type
type cb_ok1 from commandbutton within w_ctx_doc_scan_cp
end type
type cbx_pdf from checkbox within w_ctx_doc_scan_cp
end type
type cb_ok from commandbutton within w_ctx_doc_scan_cp
end type
type cb_cancel from commandbutton within w_ctx_doc_scan_cp
end type
type lb_1 from listbox within w_ctx_doc_scan_cp
end type
type gb_1 from groupbox within w_ctx_doc_scan_cp
end type
type ole_scan from olecustomcontrol within w_ctx_doc_scan_cp
end type
end forward

global type w_ctx_doc_scan_cp from w_response
integer x = 214
integer y = 221
integer width = 1600
integer height = 536
string title = "Scan Document"
boolean controlmenu = false
long backcolor = 33551856
st_page st_page
pb_next pb_next
pb_prior pb_prior
cb_cancel1 cb_cancel1
cb_ok1 cb_ok1
cbx_pdf cbx_pdf
cb_ok cb_ok
cb_cancel cb_cancel
lb_1 lb_1
gb_1 gb_1
ole_scan ole_scan
end type
global w_ctx_doc_scan_cp w_ctx_doc_scan_cp

type variables
String is_image_file
String is_run_mode

n_cst_image_functions_cp inv_image_func 

oleobject iole_object
end variables

forward prototypes
public subroutine of_adjust_ui ()
public subroutine of_set_page_info ()
end prototypes

public subroutine of_adjust_ui ();SetRedraw(FALSE)

This.title = 'Scan Document'

This.width = 2160
This.Height = 2280

ole_scan.x = 0
ole_scan.y = 0
ole_scan.width = 2098
ole_scan.height = 2044

gb_1.Visible = FALSE
lb_1.Visible = FALSE
lb_1.Enabled = FALSE
cb_ok1.Visible = FALSE
cb_ok1.Enabled = FALSE
cb_cancel1.Visible = FALSE
cb_cancel1.Enabled = FALSE

ole_scan.Visible = TRUE
ole_scan.Enabled = TRUE
cbx_pdf.Visible = TRUE
cbx_pdf.Enabled = TRUE
cb_ok.visible = TRUE
cb_ok.Enabled = TRUE
cb_cancel.Visible = TRUE
cb_cancel.Enabled = TRUE

this.center = TRUE
cbx_pdf.checked = True
SetRedraw(TRUE)

end subroutine

public subroutine of_set_page_info ();Long ll_page_cnt, ll_current_page
ll_page_cnt = ole_scan.object.totalpage
ll_current_page = ole_scan.object.GetActivePageNo()


st_page.visible = True
pb_next.visible = True
pb_prior.visible = True
st_page.text = "Page " + String(ll_current_page) + " of " + String(ll_page_cnt)

end subroutine

on w_ctx_doc_scan_cp.create
int iCurrent
call super::create
this.st_page=create st_page
this.pb_next=create pb_next
this.pb_prior=create pb_prior
this.cb_cancel1=create cb_cancel1
this.cb_ok1=create cb_ok1
this.cbx_pdf=create cbx_pdf
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.lb_1=create lb_1
this.gb_1=create gb_1
this.ole_scan=create ole_scan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_page
this.Control[iCurrent+2]=this.pb_next
this.Control[iCurrent+3]=this.pb_prior
this.Control[iCurrent+4]=this.cb_cancel1
this.Control[iCurrent+5]=this.cb_ok1
this.Control[iCurrent+6]=this.cbx_pdf
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.lb_1
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.ole_scan
end on

on w_ctx_doc_scan_cp.destroy
call super::destroy
destroy(this.st_page)
destroy(this.pb_next)
destroy(this.pb_prior)
destroy(this.cb_cancel1)
destroy(this.cb_ok1)
destroy(this.cbx_pdf)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.lb_1)
destroy(this.gb_1)
destroy(this.ole_scan)
end on

event pfc_postopen;call super::pfc_postopen;Integer li_count, i 

//Get run mode
is_run_mode = Message.StringParm 

//Set window's title
This.title = "Select Source"

//Initilize source list
SetRedraw(FALSE)

li_count = ole_scan.object.GetNumImageSources()
For i = 0 To li_count - 1
	lb_1.Additem(ole_scan.object.GetImageSourceName(i))
Next
IF li_count > 0 THEN lb_1.SelectItem(1)

SetRedraw(TRUE)


end event

event close;call super::close;IF IsValid(inv_image_func) THEN Destroy inv_image_func
end event

type st_page from statictext within w_ctx_doc_scan_cp
integer x = 626
integer y = 2080
integer width = 315
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Page 1 of 1"
boolean focusrectangle = false
end type

type pb_next from picturebutton within w_ctx_doc_scan_cp
integer x = 1061
integer y = 2064
integer width = 101
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "VCRNext!"
alignment htextalign = left!
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>w_ctx_doc_scan_cp()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-12-11 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_page_cnt, ll_current_page
ll_page_cnt = ole_scan.object.totalpage
ll_current_page = ole_scan.object.GetActivePageNo()

If ll_current_page < ll_page_cnt Then
	ole_scan.object.SetActivePageNo(ll_current_page + 1)
	//st_page.text = "Page " + String(ll_current_page + 1) + " of " + String(ll_page_cnt)
	of_set_page_info()
End If
end event

type pb_prior from picturebutton within w_ctx_doc_scan_cp
integer x = 955
integer y = 2064
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "VCRPrior!"
alignment htextalign = left!
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>w_ctx_doc_scan_cp()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-12-11 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_page_cnt, ll_current_page
ll_page_cnt = ole_scan.object.totalpage
ll_current_page = ole_scan.object.GetActivePageNo()

If ll_current_page > 1 Then
	ole_scan.object.SetActivePageNo(ll_current_page - 1)
	//st_page.text = "Page " + String(ll_current_page - 1) + " of " + String(ll_page_cnt)
	of_set_page_info()
End If
end event

type cb_cancel1 from commandbutton within w_ctx_doc_scan_cp
integer x = 1275
integer y = 188
integer width = 288
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close( Parent )
end event

type cb_ok1 from commandbutton within w_ctx_doc_scan_cp
integer x = 1275
integer y = 72
integer width = 288
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;string ls_time
Integer li_newcount, li_index

//Get the index of the selected source
li_index = lb_1.SelectedIndex() 
IF NOT li_index > 0 THEN RETURN

//Adjust UI if not a background mode
IF Lower(is_run_mode) <> 'background' THEN of_adjust_ui()

//Added By Ken.Guo 2009-12-09.
gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Scan\")

//Get the file's name to scan 
ls_time = string(minute(now())) + string(second(now()))
is_image_file = gs_dir_path + gs_DefDirName + "\Scan\temp" + ls_time + ".tif"
IF FileExists(is_image_file) THEN FileDelete( is_image_file )

cb_ok.enabled = False //Added By Ken.Guo 2009-12-11.
cb_cancel.enabled = False //Added By Ken.Guo 2009-12-11.

//Setup and scan images
inv_image_func = CREATE n_cst_image_functions_cp 
if inv_image_func.of_setup_scan( ole_scan, is_image_file, li_index -1) = -1 then
	IF FileExists(is_image_file) THEN filedelete(is_image_file)
	is_image_file = ""
	Messagebox("Scanning","Scanning has failed to complete.  The Scan OCX has reported an error while scanning.")
	cb_ok.enabled = True  //Added By Ken.Guo 2009-12-11.
	cb_cancel.enabled = True //Added By Ken.Guo 2009-12-11.
	IF Lower(is_run_mode) = 'background' THEN cb_cancel.event clicked()	
	return
end if

cb_ok.enabled = True //Added By Ken.Guo 2009-12-11.
cb_cancel.enabled = True //Added By Ken.Guo 2009-12-11.
 
//Fix the image to current display area
ole_scan.Object.View = 9 

//Close and return the scanned file name if a background mode
IF Lower(is_run_mode) = 'background' THEN 
	cbx_pdf.checked = False //Added By Ken.Guo 2009-12-11.
	cb_ok.event clicked()
End If

Post of_set_page_info() //Added By Ken.Guo 2009-12-11.
end event

type cbx_pdf from checkbox within w_ctx_doc_scan_cp
integer x = 18
integer y = 2060
integer width = 480
integer height = 104
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Convert to PDF"
end type

type cb_ok from commandbutton within w_ctx_doc_scan_cp
boolean visible = false
integer x = 1536
integer y = 2060
integer width = 279
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&OK"
end type

event clicked;
IF cbx_pdf.Checked = TRUE THEN
	//Convert to PDF
	IF Len(is_image_file) > 4 THEN	
		//Modified By Ken.Guo 2009-11-19. Use of_convert2pdf(). because scaner.save() function is poor. 
		//ole_scan.Object.Save(Mid(is_image_file, 1, Len(is_image_file) - 4), 'pdf')
		inv_image_func.of_convert2pdf(is_image_file)
		is_image_file = Mid(is_image_file, 1, Len(is_image_file) - 4) + ".pdf"
	END IF
END IF

Post CloseWithReturn( Parent, is_image_file)
end event

type cb_cancel from commandbutton within w_ctx_doc_scan_cp
boolean visible = false
integer x = 1819
integer y = 2060
integer width = 279
integer height = 104
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Cancel"
boolean cancel = true
end type

event clicked;IF Len(Trim(is_image_file)) > 0 AND FileExists(is_image_file) THEN
	FileDelete( is_image_file )
END IF

Close( Parent )
end event

type lb_1 from listbox within w_ctx_doc_scan_cp
integer x = 64
integer y = 84
integer width = 1147
integer height = 324
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_ctx_doc_scan_cp
integer x = 37
integer y = 16
integer width = 1207
integer height = 416
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Source"
end type

type ole_scan from olecustomcontrol within w_ctx_doc_scan_cp
event click ( )
event dblclick ( )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event endscan ( )
event ocrrecognized ( boolean bsuccess )
event directscanedpage ( string strfilename )
event scanningerror ( )
event endallscan ( )
event directscanedallpage ( )
integer x = 498
integer y = 172
integer width = 123
integer height = 124
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_ctx_doc_scan_cp.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event endscan();IF IsValid(inv_image_func) THEN inv_image_func.of_set_scanflag(TRUE)
end event

event constructor;This.object.licensekey = '9970'
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
07w_ctx_doc_scan_cp.bin 
2B00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffe00000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000030000000000000000000000000000000000000000000000000000000046ec39e001d32d0100000003000002c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000440000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000002000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004831a607c4f8e77ca05987fb3fa63ac740000000046ec39e001d32d0146ec39e001d32d0100000000000000000000000000000001fffffffe000000030000000400000005fffffffefffffffe00000008000000090000000afffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f004300790070006900720068006700200074006300280020002900300032003500300056002000730069006f00630020006d006f00530074006600610077006500720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe00020106831a607c4f8e77ca05987fb3fa63ac7400000001fb8f0821101b01640008ed8413c72e2b00000030000000a40000000500000100000000300000010100000038000001020000004000000103000000480000000000000050000000030001000000000003000002ca000000030000033400000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000002ca000003340000000000000064000000000000000064040000006f6d6550000000000000000000000000000000000000000000000000000000ffffffff000000030000000400000001ffffffff0000000200000000000014ac000014ac00000092000900010049030000020000000000090004000001030000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffff00000005ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000060000002a00000000004f00020065006c007200500073006500300030000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000020018ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000007000000d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050008020b0000000000000000000500c8020c000300c8001e000000000005000101020007000002fc00000000000000000000000000040000012d000000090021061d00c800f0000000c80007000002fc0000ffff0000000000ff000000040001012d00000004000001f000000004ffff0127000000030000000000000000000000000000000000000000494e414e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17w_ctx_doc_scan_cp.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
