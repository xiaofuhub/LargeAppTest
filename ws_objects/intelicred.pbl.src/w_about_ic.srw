$PBExportHeader$w_about_ic.srw
forward
global type w_about_ic from window
end type
type r_1 from rectangle within w_about_ic
end type
type st_full from statictext within w_about_ic
end type
type st_9 from statictext within w_about_ic
end type
type st_ro from statictext within w_about_ic
end type
type st_5 from statictext within w_about_ic
end type
type shl_zip_link from statichyperlink within w_about_ic
end type
type st_3 from statictext within w_about_ic
end type
type shl_isg from statichyperlink within w_about_ic
end type
type st_7 from statictext within w_about_ic
end type
type shl_zip from statichyperlink within w_about_ic
end type
type shl_cow from statichyperlink within w_about_ic
end type
type st_6 from statictext within w_about_ic
end type
type st_subdate from statictext within w_about_ic
end type
type st_subend from statictext within w_about_ic
end type
type cb_sub from commandbutton within w_about_ic
end type
type p_2 from picture within w_about_ic
end type
type p_ver from picture within w_about_ic
end type
type st_license from statictext within w_about_ic
end type
type st_4 from statictext within w_about_ic
end type
type cb_license_new from commandbutton within w_about_ic
end type
type cb_1 from commandbutton within w_about_ic
end type
type st_ver from statictext within w_about_ic
end type
type st_copy from statictext within w_about_ic
end type
type st_2 from statictext within w_about_ic
end type
type st_1 from statictext within w_about_ic
end type
type gb_1 from groupbox within w_about_ic
end type
type st_zip from statictext within w_about_ic
end type
type st_about_test from statictext within w_about_ic
end type
type p_1 from picture within w_about_ic
end type
end forward

global type w_about_ic from window
integer x = 823
integer y = 360
integer width = 2793
integer height = 1840
boolean titlebar = true
string title = "IntelliSoft Group"
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
r_1 r_1
st_full st_full
st_9 st_9
st_ro st_ro
st_5 st_5
shl_zip_link shl_zip_link
st_3 st_3
shl_isg shl_isg
st_7 st_7
shl_zip shl_zip
shl_cow shl_cow
st_6 st_6
st_subdate st_subdate
st_subend st_subend
cb_sub cb_sub
p_2 p_2
p_ver p_ver
st_license st_license
st_4 st_4
cb_license_new cb_license_new
cb_1 cb_1
st_ver st_ver
st_copy st_copy
st_2 st_2
st_1 st_1
gb_1 gb_1
st_zip st_zip
st_about_test st_about_test
p_1 p_1
end type
global w_about_ic w_about_ic

on w_about_ic.create
this.r_1=create r_1
this.st_full=create st_full
this.st_9=create st_9
this.st_ro=create st_ro
this.st_5=create st_5
this.shl_zip_link=create shl_zip_link
this.st_3=create st_3
this.shl_isg=create shl_isg
this.st_7=create st_7
this.shl_zip=create shl_zip
this.shl_cow=create shl_cow
this.st_6=create st_6
this.st_subdate=create st_subdate
this.st_subend=create st_subend
this.cb_sub=create cb_sub
this.p_2=create p_2
this.p_ver=create p_ver
this.st_license=create st_license
this.st_4=create st_4
this.cb_license_new=create cb_license_new
this.cb_1=create cb_1
this.st_ver=create st_ver
this.st_copy=create st_copy
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.st_zip=create st_zip
this.st_about_test=create st_about_test
this.p_1=create p_1
this.Control[]={this.r_1,&
this.st_full,&
this.st_9,&
this.st_ro,&
this.st_5,&
this.shl_zip_link,&
this.st_3,&
this.shl_isg,&
this.st_7,&
this.shl_zip,&
this.shl_cow,&
this.st_6,&
this.st_subdate,&
this.st_subend,&
this.cb_sub,&
this.p_2,&
this.p_ver,&
this.st_license,&
this.st_4,&
this.cb_license_new,&
this.cb_1,&
this.st_ver,&
this.st_copy,&
this.st_2,&
this.st_1,&
this.gb_1,&
this.st_zip,&
this.st_about_test,&
this.p_1}
end on

on w_about_ic.destroy
destroy(this.r_1)
destroy(this.st_full)
destroy(this.st_9)
destroy(this.st_ro)
destroy(this.st_5)
destroy(this.shl_zip_link)
destroy(this.st_3)
destroy(this.shl_isg)
destroy(this.st_7)
destroy(this.shl_zip)
destroy(this.shl_cow)
destroy(this.st_6)
destroy(this.st_subdate)
destroy(this.st_subend)
destroy(this.cb_sub)
destroy(this.p_2)
destroy(this.p_ver)
destroy(this.st_license)
destroy(this.st_4)
destroy(this.cb_license_new)
destroy(this.cb_1)
destroy(this.st_ver)
destroy(this.st_copy)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.st_zip)
destroy(this.st_about_test)
destroy(this.p_1)
end on

event open;//Start Code Change ---- 03.13.2007 #V7 maha
if upper(appeongetclienttype())  = "WEB" then
	//gs_user_version =  "Version 7.0"   //Commented by Ken.Guo 04.09.2008
	gs_user_version = gnv_app.of_getversion( ) //Added By Ken.Guo 04.09.2008
	st_ver.text =  gs_user_version //Added By Ken.Guo 04.09.2008
else
	st_ver.text = gs_user_version
end if
//End Code Change---03.13.2007
st_1.text = w_mdi.title

//Start Code Change ----08.26.2010 #V10 maha
integer li_sub
integer li_num //03.03.2016
datetime ldt_sub
select pp_s into :li_sub from ids;

if li_sub > 0 then 
	cb_sub.visible = true
	st_subend.visible = true
	select pp_date into :ldt_sub from ids; 
	st_subdate.text = string(date(ldt_sub))
	st_subdate.visible = true
end if
//End Code Change---08.26.2010

st_license.text = gnv_session.is_license_key
li_num = integer(mid( gnv_session.is_license_key , 8, 3 ))
st_full.text = string(li_num)
li_num = integer(mid( gnv_session.is_license_key , 15, 3 ))
st_ro.text =  string(li_num)

if gi_user_readonly = 1 then
	cb_sub.visible = false
	cb_license_new.visible = false
	st_license.visible = false
end if

//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
//Start Code Change ----07.14.2014 #V14.2 maha - removed as not needed
//if gb_contract_module then
//	st_6.visible = True
//	shl_1.visible = True
//else
//	st_6.visible = False
//	shl_1.visible = False
//end if
//---------End Added ------------------------------------------------------
end event

type r_1 from rectangle within w_about_ic
integer linethickness = 4
long fillcolor = 16777215
integer x = 18
integer y = 12
integer width = 2747
integer height = 304
end type

type st_full from statictext within w_about_ic
integer x = 1591
integer y = 1372
integer width = 201
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_9 from statictext within w_about_ic
integer x = 1819
integer y = 1372
integer width = 265
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Read-only:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_ro from statictext within w_about_ic
integer x = 2089
integer y = 1372
integer width = 201
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_5 from statictext within w_about_ic
integer x = 1326
integer y = 1372
integer width = 256
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Full Users:"
alignment alignment = right!
boolean focusrectangle = false
end type

type shl_zip_link from statichyperlink within w_about_ic
integer x = 1637
integer y = 1228
integer width = 1001
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 33551856
string text = "http://creativecommons.org/licenses"
boolean focusrectangle = false
string url = "http://creativecommons.org/licenses/by-sa/2.0/legalcode"
end type

type st_3 from statictext within w_about_ic
integer x = 827
integer y = 712
integer width = 1093
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Copyright 1998 - 2017  ISG Group.LLC"
alignment alignment = center!
boolean focusrectangle = false
end type

type shl_isg from statichyperlink within w_about_ic
integer x = 1061
integer y = 624
integer width = 677
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 33551856
string text = "www.intellisoftgroup.com"
boolean focusrectangle = false
string url = "www.intellisoftgroup.com"
end type

type st_7 from statictext within w_about_ic
integer x = 206
integer y = 1044
integer width = 1733
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "7-Zip is licensed under the GNU LGPL license. For more info see "
boolean focusrectangle = false
end type

type shl_zip from statichyperlink within w_about_ic
integer x = 1938
integer y = 1052
integer width = 462
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 33551856
string text = "www.7-zip.org"
boolean focusrectangle = false
string url = "www.7-zip.org"
end type

type shl_cow from statichyperlink within w_about_ic
boolean visible = false
integer x = 1655
integer y = 1916
integer width = 987
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 33551856
string text = "http://www.fatcow.com/free-icons"
boolean focusrectangle = false
string url = "http://www.fatcow.com/free-icons"
end type

type st_6 from statictext within w_about_ic
boolean visible = false
integer x = 201
integer y = 1916
integer width = 1445
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Some of the icons used in this application come from "
boolean focusrectangle = false
end type

type st_subdate from statictext within w_about_ic
boolean visible = false
integer x = 640
integer y = 1504
integer width = 1074
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " "
boolean focusrectangle = false
end type

type st_subend from statictext within w_about_ic
boolean visible = false
integer x = 160
integer y = 1504
integer width = 466
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Subscription ends:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_sub from commandbutton within w_about_ic
boolean visible = false
integer x = 1714
integer y = 1488
integer width = 539
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Subscription Code..."
end type

event clicked;Openwithparm(w_install_module_update,"S")
end event

type p_2 from picture within w_about_ic
integer x = 2976
integer y = 660
integer width = 389
integer height = 320
string picturename = "isg2.bmp"
boolean focusrectangle = false
end type

type p_ver from picture within w_about_ic
integer x = 2926
integer y = 624
integer width = 389
integer height = 320
string picturename = "rolodex.bmp"
boolean focusrectangle = false
end type

type st_license from statictext within w_about_ic
integer x = 361
integer y = 1372
integer width = 827
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_4 from statictext within w_about_ic
integer x = 37
integer y = 1372
integer width = 338
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "License Key:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_license_new from commandbutton within w_about_ic
integer x = 2336
integer y = 1364
integer width = 398
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&New License..."
end type

event clicked;Open(w_install_module_update)
If Message.Stringparm = 'OK' Then
	st_license.text = gnv_session.is_license_key
End If
end event

type cb_1 from commandbutton within w_about_ic
integer x = 1216
integer y = 1624
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;close(parent)
end event

type st_ver from statictext within w_about_ic
integer x = 242
integer y = 896
integer width = 2277
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "version"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_copy from statictext within w_about_ic
integer x = 1015
integer y = 540
integer width = 727
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "IntelliSoft Group"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_about_ic
integer x = 1129
integer y = 800
integer width = 521
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Version Info: "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_about_ic
integer x = 69
integer y = 392
integer width = 2642
integer height = 120
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "IntelliCred for Windows"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_about_ic
integer x = 192
integer y = 1092
integer width = 2757
integer height = 8
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type st_zip from statictext within w_about_ic
integer x = 69
integer y = 1160
integer width = 2688
integer height = 176
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Zip Code data licensed under the Creative Commons Attribution-ShareAlike license by CivicSpace Labs written by Schuyler Erle <schuyler@geocoder.us>."
boolean focusrectangle = false
end type

type st_about_test from statictext within w_about_ic
integer x = 165
integer y = 1164
integer width = 233
integer height = 124
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_about_ic
integer x = 818
integer y = 24
integer width = 1143
integer height = 280
boolean bringtotop = true
string picturename = "ISG-email-Logo 2017.png"
boolean focusrectangle = false
end type

