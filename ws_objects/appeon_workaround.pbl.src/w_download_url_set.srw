$PBExportHeader$w_download_url_set.srw
forward
global type w_download_url_set from window
end type
type st_1 from statictext within w_download_url_set
end type
type cb_3 from commandbutton within w_download_url_set
end type
type sle_url from singlelineedit within w_download_url_set
end type
type cb_1 from commandbutton within w_download_url_set
end type
end forward

global type w_download_url_set from window
integer width = 2469
integer height = 460
boolean titlebar = true
string title = "Download file setting"
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
global w_download_url_set w_download_url_set

type variables
n_cst_encrypt invo_encrypt 
integer ii_cnt
end variables

on w_download_url_set.create
this.st_1=create st_1
this.cb_3=create cb_3
this.sle_url=create sle_url
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_3,&
this.sle_url,&
this.cb_1}
end on

on w_download_url_set.destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.sle_url)
destroy(this.cb_1)
end on

event open;String ls_sql
ls_sql = "Alter table icred_settings add downloadurl varchar(255) null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;


String ls_url
ls_url = gnv_data.of_getitem( "icred_settings", "downloadurl", false)


sle_url.text = ls_url
end event

type st_1 from statictext within w_download_url_set
integer x = 18
integer y = 12
integer width = 2414
integer height = 84
integer textsize = -10
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

type cb_3 from commandbutton within w_download_url_set
integer x = 2158
integer y = 252
integer width = 265
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;CLOSE(PARENT)
end event

type sle_url from singlelineedit within w_download_url_set
integer x = 14
integer y = 120
integer width = 2427
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_download_url_set
integer x = 1842
integer y = 252
integer width = 265
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;String ls_url

ls_url = Trim(sle_url.text)

if RightA(ls_url,1) <> "/" then
	ls_url += "/"
end if

sle_url.text = ls_url

Update icred_settings set downloadurl = :ls_url;
commit using sqlca;

gnv_data.of_retrieve( "icred_settings" )

end event

