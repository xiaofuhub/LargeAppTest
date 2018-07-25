$PBExportHeader$w_get_license_key_clx.srw
forward
global type w_get_license_key_clx from window
end type
type st_4 from statictext within w_get_license_key_clx
end type
type st_3 from statictext within w_get_license_key_clx
end type
type sle_ro from singlelineedit within w_get_license_key_clx
end type
type sle_fau from singlelineedit within w_get_license_key_clx
end type
type cbx_workflow from checkbox within w_get_license_key_clx
end type
type cbx_export from checkbox within w_get_license_key_clx
end type
type cbx_import from checkbox within w_get_license_key_clx
end type
type cbx_reports from checkbox within w_get_license_key_clx
end type
type cbx_create from checkbox within w_get_license_key_clx
end type
type cb_copy from commandbutton within w_get_license_key_clx
end type
type cb_2 from commandbutton within w_get_license_key_clx
end type
type cb_1 from commandbutton within w_get_license_key_clx
end type
type st_2 from statictext within w_get_license_key_clx
end type
type sle_key from singlelineedit within w_get_license_key_clx
end type
type gb_1 from groupbox within w_get_license_key_clx
end type
end forward

global type w_get_license_key_clx from window
integer x = 1326
integer y = 624
integer width = 2107
integer height = 1040
boolean titlebar = true
string title = "CLX License Key Generator"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_4 st_4
st_3 st_3
sle_ro sle_ro
sle_fau sle_fau
cbx_workflow cbx_workflow
cbx_export cbx_export
cbx_import cbx_import
cbx_reports cbx_reports
cbx_create cbx_create
cb_copy cb_copy
cb_2 cb_2
cb_1 cb_1
st_2 st_2
sle_key sle_key
gb_1 gb_1
end type
global w_get_license_key_clx w_get_license_key_clx

type variables
datawindow idw_detail
end variables

forward prototypes
public function string of_gen_key ()
end prototypes

public function string of_gen_key ();//maha 052908 - added for license number mods for version 8
integer ro = 0
integer fu = 0
integer t = 0
integer t1 = 0
integer t2 = 0
integer prod = 0
integer db = 0
integer li_mod = 0
long ll_check
string ls_key
string ls_holder
string ls_mod
string ls_ver
string sa
string sb = 'x'
string sc = 'x'
string sd = 'x'
string se = 'x'
string rou
string sf = 'x'
string sg = 'x' 
string sh = 'x'
string ls_prod
datawindow a_dw



//full access users

sa = sle_fau.text

if not isnumber(sa) then
	messagebox ("Key failure","Unable to get number of full access users")
	return "Fail"
else
	fu = integer(sa)
end if

if LenA(sa) = 1 then //number of users for aa
	ls_holder = "00" + sa
elseif LenA(sa) = 2 then
	ls_holder = "0" + sa
else
	ls_holder = sa
end if

//read only users

if sle_ro.text = "0" then
	ro = 0
else
	ro = integer(sle_ro.text)
end if

rou = string(ro)

if LenA(rou) = 0 then
	rou = "000"
elseif LenA(rou) = 1 then //number of users for rrr
	rou = "00" + rou
elseif LenA(rou) = 2 then
	rou = "0" + rou
else
	//rou = rou
end if


//ISG 0900 aaabcde rrrfghii
//number of users		aaa
//app						b	7,5,4,2
//image					b	--
//install imaging		c	9,1		
//priv					d	9,8,7,6,5,4,3,0
//webview				d	--
//workflow				d	--
//report					e	9,8,7,6,5,4,3,0
//export					e	--
//import 				e	--
//read only users		rrr
//contract				f	9,8,7,6,5,4,3,0
//qa						f	--
//contact create		f	--
//peer					h	9,4,3,1
//site					h	--
//program				g	9,8,7
//checksum 				i
//checksum2				i2

//added contract creation, import and workflow 10-30-08

t = 0 //a_dw.getitemnumber(1,"contacts_module_intelliapp")
if prod = 6 then t = 1
t1 = 0 //a_dw.getitemnumber(1,"contacts_module_imaging")

if t = 1 then
	if t1 = 1 then
		sb =  "7"
	else
		sb = "5"
	end if
else
	if t1 = 1 then
		sb = "4"
	else
		sb = "2"
	end if
end if

//choose case sb  //if iapp or imaging install imaging module
//	case "7","5","4"
		sc = "9"
//	case else
//		sc = "1"
//end choose
//if a_dw.getitemnumber(1,"contacts_module_imaging") = 1 then//c  do not add to this the installer uses this number
//	sc = "9"
//else
//	sc = "1"
//end if
//if a_dw.getitemnumber(1,"contacts_module_iprivilage") = 1 then //d
//	sd = "8"
//else
//	sd = "0"
//end if

//D
//t = a_dw.getitemnumber(1,"contacts_module_iprivilage")
t = 0  //a_dw.getitemnumber(1,"module_privilege")
t1 = 0	//a_dw.getitemnumber(1,"contacts_module_webview")
//t2 = a_dw.getitemnumber(1,"contacts_module_workflow")
if cbx_workflow.checked then t2 = 1


if t = 1 and t1 = 1 and t2 = 1 then
	sd = "9"
elseif t = 1 and t1 = 1 and t2 = 0 then
	sd = "8"
elseif t = 1 and t1 = 0 and t2 = 1 then
	sd = "7"
elseif t = 1 and t1 = 0 and t2 = 0 then
	sd = "6"
elseif t = 0 and t1 = 1 and t2 = 1 then
	sd = "5"
elseif t = 0 and t1 = 1 and t2 = 0 then
	sd = "4"
elseif t = 0 and t1 = 0 and t2 = 1 then
	sd = "3"
elseif t = 0 and t1 = 0 and t2 = 0 then
	sd = "0"	
end if
//if t = 1 then
//	if t1 = 1 then
//		sd =  "8"
//	else
//		sd = "6"
//	end if
//else
//	if t1 = 1 then
//		sd = "4"
//	else
//		sd = "0"
//	end if
//end if

t =0
t1 = 0
t2 = 0

if cbx_reports.checked then t = 1 
if cbx_export.checked then t1 = 1 
if cbx_import.checked then t2 = 1 

//t = a_dw.getitemnumber(1,"contacts_module_intellireport")
//t1 = a_dw.getitemnumber(1,"contacts_module_intelliexport")
//t2 = a_dw.getitemnumber(1,"contacts_module_import")

if t = 1 and t1 = 1 and t2 = 1 then
	se = "9"
elseif t = 1 and t1 = 1 and t2 = 0 then
	se = "8"
elseif t = 1 and t1 = 0 and t2 = 1 then
	se = "7"
elseif t = 1 and t1 = 0 and t2 = 0 then
	se = "6"
elseif t = 0 and t1 = 1 and t2 = 1 then
	se = "5"
elseif t = 0 and t1 = 1 and t2 = 0 then
	se = "4"
elseif t = 0 and t1 = 0 and t2 = 1 then
	se = "3"
elseif t = 0 and t1 = 0 and t2 = 0 then
	se = "0"	
end if

//if t = 1 then
//	if t1 = 1 then
//		se =  "9"
//	else
//		se = "5"
//	end if
//else
//	if t1 = 1 then
//		se = "3"
//	else
//		se = "1"
//	end if
//end if

t = 1
t1 = 0
t2 = 0
//F
//t = a_dw.getitemnumber(1,"contacts_module_contracts")
//t1 = a_dw.getitemnumber(1,"contacts_module_qa")
if cbx_create.checked then t2 = 1
//t2 = a_dw.getitemnumber(1,"contacts_module_ctx_create")

if t = 1 and t1 = 1 and t2 = 1 then
	sf = "9"
elseif t = 1 and t1 = 1 and t2 = 0 then
	sf = "8"
elseif t = 1 and t1 = 0 and t2 = 1 then
	sf = "7"
elseif t = 1 and t1 = 0 and t2 = 0 then
	sf = "6"
elseif t = 0 and t1 = 1 and t2 = 1 then
	sf = "5"
elseif t = 0 and t1 = 1 and t2 = 0 then
	sf = "4"
elseif t = 0 and t1 = 0 and t2 = 1 then
	sf = "3"
elseif t = 0 and t1 = 0 and t2 = 0 then
	sf = "0"	
end if

//a = 9,8,7,6
//b = 9,8,5,4
//c = 9,7,5,3

//if t = 1 then
//	if t1 = 1 then
//		sf = "7"
//	else
//		sf = "6"
//	end if
//else
//	if t1 = 1 then
//		sf = "4"
//	else
//		sf = "2"
//	end if
//end if


sg = "7"


t = 0 // a_dw.getitemnumber(1,"contacts_module_peer")
t1 = 0  //a_dw.getitemnumber(1,"contacts_module_site")

//if t = 1 then
//	if t1 = 1 then
//		sh = "9"
//	else
//		sh = "4"
//	end if
//else
//	if t1 = 1 then
//		sh = "3"
//	else
//		sh = "1"
//	end if
//end if
sh = "1" 

//get check sum value
ll_check = (integer(sa) + integer(sb)  + integer(sc)  + integer(sd)  + integer(se)) * ( integer(rou)  + integer(sf)  + integer(sg)  + integer(sh))
ll_check = mod(ll_check,10)

//second checksum
li_mod = integer(sa) + integer(rou) + 10
li_mod = mod(li_mod,9)

ls_mod = sb + sc + sd + se + " " + rou + sf + sg + sh + string( ll_check) + string(li_mod)


db = 1
//db = a_dw.getitemnumber(1,"contacts_tutor_db")  //using for ASA /SQL db
if isnull(db) then db = 0

ls_key = "CLX 0901" //+ string(db)


ls_key = ls_key + " " + ls_holder + ls_mod


return ls_key
end function

on w_get_license_key_clx.create
this.st_4=create st_4
this.st_3=create st_3
this.sle_ro=create sle_ro
this.sle_fau=create sle_fau
this.cbx_workflow=create cbx_workflow
this.cbx_export=create cbx_export
this.cbx_import=create cbx_import
this.cbx_reports=create cbx_reports
this.cbx_create=create cbx_create
this.cb_copy=create cb_copy
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.sle_key=create sle_key
this.gb_1=create gb_1
this.Control[]={this.st_4,&
this.st_3,&
this.sle_ro,&
this.sle_fau,&
this.cbx_workflow,&
this.cbx_export,&
this.cbx_import,&
this.cbx_reports,&
this.cbx_create,&
this.cb_copy,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.sle_key,&
this.gb_1}
end on

on w_get_license_key_clx.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_ro)
destroy(this.sle_fau)
destroy(this.cbx_workflow)
destroy(this.cbx_export)
destroy(this.cbx_import)
destroy(this.cbx_reports)
destroy(this.cbx_create)
destroy(this.cb_copy)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.sle_key)
destroy(this.gb_1)
end on

type st_4 from statictext within w_get_license_key_clx
integer x = 1024
integer y = 460
integer width = 261
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
boolean enabled = false
string text = "Readonly"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_get_license_key_clx
integer x = 270
integer y = 464
integer width = 320
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
boolean enabled = false
string text = "Full access"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_ro from singlelineedit within w_get_license_key_clx
integer x = 1330
integer y = 456
integer width = 247
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_fau from singlelineedit within w_get_license_key_clx
integer x = 617
integer y = 456
integer width = 247
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cbx_workflow from checkbox within w_get_license_key_clx
integer x = 1614
integer y = 248
integer width = 325
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
string text = "Workflow"
end type

type cbx_export from checkbox within w_get_license_key_clx
integer x = 503
integer y = 248
integer width = 256
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
string text = "Export"
end type

type cbx_import from checkbox within w_get_license_key_clx
integer x = 850
integer y = 248
integer width = 247
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
string text = "Import"
end type

type cbx_reports from checkbox within w_get_license_key_clx
integer x = 1225
integer y = 248
integer width = 288
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
string text = "Reports"
end type

type cbx_create from checkbox within w_get_license_key_clx
integer x = 82
integer y = 248
integer width = 302
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
string text = "Creation"
end type

type cb_copy from commandbutton within w_get_license_key_clx
integer x = 1262
integer y = 24
integer width = 535
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copy to Clipboard"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_get_license_key_clx
integer x = 1824
integer y = 24
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_get_license_key_clx
integer x = 823
integer y = 24
integer width = 421
integer height = 84
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generate Key"
end type

event clicked;string ls_ver
string ls_key

//ls_ver = sle_ver.text

//choose case ls_ver
//	case "3","4"
//		ls_key = of_key_code_3_4(idw_detail)
//	case "5", "6", "7", "8"
//		ls_key = of_key_code(idw_detail)
//	case "9"
//		ls_key = of_key_code_9(idw_detail)
//	case else
//		messagebox("Generate license key","Version should be a single number")
//end choose

ls_key = of_gen_key()

if LenA(ls_key) > 0 then
	sle_key.text = ls_key
end if
end event

type st_2 from statictext within w_get_license_key_clx
integer x = 155
integer y = 712
integer width = 293
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
boolean enabled = false
string text = "Install Key"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_key from singlelineedit within w_get_license_key_clx
integer x = 485
integer y = 700
integer width = 1349
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_get_license_key_clx
integer x = 219
integer y = 376
integer width = 1445
integer height = 212
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551856
string text = "Users"
end type

