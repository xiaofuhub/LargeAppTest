$PBExportHeader$w_pdf_download_url.srw
forward
global type w_pdf_download_url from window
end type
type st_1 from statictext within w_pdf_download_url
end type
type cb_3 from commandbutton within w_pdf_download_url
end type
type sle_url from singlelineedit within w_pdf_download_url
end type
type cb_1 from commandbutton within w_pdf_download_url
end type
end forward

global type w_pdf_download_url from window
integer width = 2446
integer height = 420
boolean titlebar = true
string title = "PDF Printer Download setting"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_3 cb_3
sle_url sle_url
cb_1 cb_1
end type
global w_pdf_download_url w_pdf_download_url

type variables
n_cst_encrypt invo_encrypt 
integer ii_cnt
end variables

on w_pdf_download_url.create
this.st_1=create st_1
this.cb_3=create cb_3
this.sle_url=create sle_url
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_3,&
this.sle_url,&
this.cb_1}
end on

on w_pdf_download_url.destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.sle_url)
destroy(this.cb_1)
end on

event open;String	ls_PntDlPath

Select PntDownLoadPath into :ls_PntDlPath from icred_settings;

if IsNull(ls_PntDlPath) then ls_PntDlPath = ""

sle_url.text = ls_PntDlPath

end event

type st_1 from statictext within w_pdf_download_url
integer x = 18
integer y = 12
integer width = 2336
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Input the directory in the following format:  http://web server ip:port/intellicred/templates/"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_pdf_download_url
integer x = 2139
integer y = 236
integer width = 265
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type sle_url from singlelineedit within w_pdf_download_url
integer x = 14
integer y = 120
integer width = 2391
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_pdf_download_url
integer x = 1824
integer y = 236
integer width = 265
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;String ls_url

ls_url = Trim(sle_url.text)

if ls_url <> "" and RightA(ls_url,1) <> "/" then
	ls_url += "/"
end if

sle_url.text = ls_url

Update icred_settings set PntDownLoadPath = :ls_url;
commit using sqlca;

end event

