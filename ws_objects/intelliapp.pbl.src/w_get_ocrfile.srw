$PBExportHeader$w_get_ocrfile.srw
forward
global type w_get_ocrfile from pfc_w_response
end type
type ole_scan from olecustomcontrol within w_get_ocrfile
end type
type cb_close from commandbutton within w_get_ocrfile
end type
type cb_scan from commandbutton within w_get_ocrfile
end type
type cb_file from commandbutton within w_get_ocrfile
end type
end forward

global type w_get_ocrfile from pfc_w_response
integer width = 741
integer height = 656
string title = "Get File"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
ole_scan ole_scan
cb_close cb_close
cb_scan cb_scan
cb_file cb_file
end type
global w_get_ocrfile w_get_ocrfile

type variables
long	il_rec_id,il_prac_id,il_app_id
string is_return
string is_type
end variables

on w_get_ocrfile.create
int iCurrent
call super::create
this.ole_scan=create ole_scan
this.cb_close=create cb_close
this.cb_scan=create cb_scan
this.cb_file=create cb_file
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_scan
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_scan
this.Control[iCurrent+4]=this.cb_file
end on

on w_get_ocrfile.destroy
call super::destroy
destroy(this.ole_scan)
destroy(this.cb_close)
destroy(this.cb_scan)
destroy(this.cb_file)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
is_return = ""
end event

type ole_scan from olecustomcontrol within w_get_ocrfile
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
string binarykey = "w_get_ocrfile.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_close from commandbutton within w_get_ocrfile
integer x = 178
integer y = 356
integer width = 343
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

event clicked;closewithreturn(parent, is_return)
end event

type cb_scan from commandbutton within w_get_ocrfile
integer x = 178
integer y = 200
integer width = 343
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
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
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

// return Image file
closewithreturn(parent, ls_scan_file)
end event

type cb_file from commandbutton within w_get_ocrfile
integer x = 178
integer y = 56
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &File..."
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string docpath, docname
integer li_rtn

li_rtn = GetFileOpenName("Select File", 	docpath, docname, "TIF",  "TIFF Files (*.tif),*.tif") 

ChangeDirectory(gs_current_path)

IF li_rtn < 1 THEN RETURN 

closewithreturn(parent, docpath)

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
00w_get_ocrfile.bin 
2D00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c302762001d10c1500000003000002000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000014900000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff0000000384926ca0101c2941600e6f817f4b111300000000c302762001d10c15c302762001d10c15000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000600000054000000000000000100000002000000030000000400000005fffffffe00000007fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe0002020684926ca0101c2941600e6f817f4b111300000001fb8f0821101b01640008ed8413c72e2b00000030000001190000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000007400000000000000940000000300010000000000030000034f000000030000034f00000003000000000000001e0000000945676d4931746964000000000000001e000000174941575432335f4e6d61532020656c7072756f530000656300000007000000000000000100010500000010006c657300657463656163736472656e6e0001030000000c0074735f00706b636f73706f72000104000000110073656400616d69746f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f69730000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000034f0000034f00000000676d490874696445000100310001000000007fff00000001000100000003000100000008000000000142c80041575416335f4e4961532032656c706d756f5320006563720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10w_get_ocrfile.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
