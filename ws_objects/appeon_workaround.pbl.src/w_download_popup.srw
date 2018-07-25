$PBExportHeader$w_download_popup.srw
forward
global type w_download_popup from window
end type
type st_1 from statictext within w_download_popup
end type
end forward

global type w_download_popup from window
integer width = 2071
integer height = 132
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
end type
global w_download_popup w_download_popup

on w_download_popup.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_download_popup.destroy
destroy(this.st_1)
end on

event open;this.center = true

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Zhang XingRen
//$<reason> 
If Message.StringParm <> "" Then
	st_1.Text = Message.StringParm
End If
//---------------------------- APPEON END ----------------------------


end event

type st_1 from statictext within w_download_popup
integer y = 32
integer width = 2057
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Downloading the template file from Server, Please stand by..."
alignment alignment = center!
boolean focusrectangle = false
end type

