$PBExportHeader$w_ftp_set.srw
forward
global type w_ftp_set from w_response
end type
type cb_11 from commandbutton within w_ftp_set
end type
type tv_1 from treeview within w_ftp_set
end type
type cb_10 from commandbutton within w_ftp_set
end type
type hpb_1 from hprogressbar within w_ftp_set
end type
type cb_9 from commandbutton within w_ftp_set
end type
type cb_8 from commandbutton within w_ftp_set
end type
type cb_7 from commandbutton within w_ftp_set
end type
type cb_6 from commandbutton within w_ftp_set
end type
type cb_5 from commandbutton within w_ftp_set
end type
type mle_1 from multilineedit within w_ftp_set
end type
type cb_4 from commandbutton within w_ftp_set
end type
type cb_3 from commandbutton within w_ftp_set
end type
type cb_2 from commandbutton within w_ftp_set
end type
type cb_dir from commandbutton within w_ftp_set
end type
type sle_remotepath from singlelineedit within w_ftp_set
end type
type sle_localpath from singlelineedit within w_ftp_set
end type
type st_7 from statictext within w_ftp_set
end type
type st_6 from statictext within w_ftp_set
end type
type sle_port from singlelineedit within w_ftp_set
end type
type st_5 from statictext within w_ftp_set
end type
type sle_password from singlelineedit within w_ftp_set
end type
type sle_login from singlelineedit within w_ftp_set
end type
type sle_hostname from singlelineedit within w_ftp_set
end type
type st_4 from statictext within w_ftp_set
end type
type st_3 from statictext within w_ftp_set
end type
type st_2 from statictext within w_ftp_set
end type
type st_1 from statictext within w_ftp_set
end type
type cb_1 from commandbutton within w_ftp_set
end type
type ddlb_protocol from dropdownlistbox within w_ftp_set
end type
type gb_1 from groupbox within w_ftp_set
end type
type gb_2 from groupbox within w_ftp_set
end type
end forward

global type w_ftp_set from w_response
integer width = 2839
integer height = 1640
string title = "FTP Test"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
cb_11 cb_11
tv_1 tv_1
cb_10 cb_10
hpb_1 hpb_1
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
mle_1 mle_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_dir cb_dir
sle_remotepath sle_remotepath
sle_localpath sle_localpath
st_7 st_7
st_6 st_6
sle_port sle_port
st_5 st_5
sle_password sle_password
sle_login sle_login
sle_hostname sle_hostname
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_1 cb_1
ddlb_protocol ddlb_protocol
gb_1 gb_1
gb_2 gb_2
end type
global w_ftp_set w_ftp_set

type variables
n_cst_ftp inv_ftp
end variables

on w_ftp_set.create
int iCurrent
call super::create
this.cb_11=create cb_11
this.tv_1=create tv_1
this.cb_10=create cb_10
this.hpb_1=create hpb_1
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.mle_1=create mle_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_dir=create cb_dir
this.sle_remotepath=create sle_remotepath
this.sle_localpath=create sle_localpath
this.st_7=create st_7
this.st_6=create st_6
this.sle_port=create sle_port
this.st_5=create st_5
this.sle_password=create sle_password
this.sle_login=create sle_login
this.sle_hostname=create sle_hostname
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.ddlb_protocol=create ddlb_protocol
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_11
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.cb_10
this.Control[iCurrent+4]=this.hpb_1
this.Control[iCurrent+5]=this.cb_9
this.Control[iCurrent+6]=this.cb_8
this.Control[iCurrent+7]=this.cb_7
this.Control[iCurrent+8]=this.cb_6
this.Control[iCurrent+9]=this.cb_5
this.Control[iCurrent+10]=this.mle_1
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.cb_dir
this.Control[iCurrent+15]=this.sle_remotepath
this.Control[iCurrent+16]=this.sle_localpath
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.st_6
this.Control[iCurrent+19]=this.sle_port
this.Control[iCurrent+20]=this.st_5
this.Control[iCurrent+21]=this.sle_password
this.Control[iCurrent+22]=this.sle_login
this.Control[iCurrent+23]=this.sle_hostname
this.Control[iCurrent+24]=this.st_4
this.Control[iCurrent+25]=this.st_3
this.Control[iCurrent+26]=this.st_2
this.Control[iCurrent+27]=this.st_1
this.Control[iCurrent+28]=this.cb_1
this.Control[iCurrent+29]=this.ddlb_protocol
this.Control[iCurrent+30]=this.gb_1
this.Control[iCurrent+31]=this.gb_2
end on

on w_ftp_set.destroy
call super::destroy
destroy(this.cb_11)
destroy(this.tv_1)
destroy(this.cb_10)
destroy(this.hpb_1)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.mle_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_dir)
destroy(this.sle_remotepath)
destroy(this.sle_localpath)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.sle_port)
destroy(this.st_5)
destroy(this.sle_password)
destroy(this.sle_login)
destroy(this.sle_hostname)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.ddlb_protocol)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;str_ftp_parms lstr_parms
String ls_protocol

inv_ftp = create n_cst_ftp
If Not IsValid(inv_ftp.iole_ftp) Then close(this)

inv_ftp.of_set_tip_object(mle_1)
inv_ftp.of_set_progressbar(hpb_1)
inv_ftp.of_set_treeview(tv_1)

//Open from test
If IsValid(Message.powerobjectparm) Then
	lstr_parms = Message.powerobjectparm
	sle_hostname.text = lstr_parms.hostname
	sle_login.text =  lstr_parms.login
	sle_password.text = lstr_parms.password
	sle_port.text = lstr_parms.port
	
	//Protocol
	Choose Case lstr_parms.protocol
		Case 0
			ls_protocol = 'FTP'
	 	Case 1
			ls_protocol = 'SFTP'
	  	Case 2
			ls_protocol = 'FTPS' // FTP+SSL protocol with insecured data channel
	 	Case 3
			ls_protocol = 'FTPS + data' //withdata, FTP+SSL protocol with secured data channel. 
	  	Case 4
			ls_protocol = 'FTPSimplicit' //FTPSimplicit 4 FTP+SSL implicit on port 990. 
	End Choose
	ddlb_protocol.text = ls_protocol
	
	cb_1.Post event clicked() //Add 'Post', by Appeon long.zhang 09.29.2015 (BugS092301)
End If

end event

event close;destroy inv_ftp
end event

event closequery;If inv_ftp.of_is_processing() Then Return 1
end event

type cb_11 from commandbutton within w_ftp_set
integer x = 2418
integer y = 36
integer width = 297
integer height = 100
integer taborder = 190
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Close(Parent)
end event

type tv_1 from treeview within w_ftp_set
integer x = 1509
integer y = 772
integer width = 1248
integer height = 704
integer taborder = 220
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string picturename[] = {"Custom039!","Custom050!",""}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type cb_10 from commandbutton within w_ftp_set
boolean visible = false
integer x = 1600
integer y = 1552
integer width = 366
integer height = 100
integer taborder = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Register DLL"
end type

event clicked;Run('Regsvr32 "'+GetCurrentDirectory ( )+'\wodFtpDLX.dll"')	
end event

type hpb_1 from hprogressbar within w_ftp_set
integer x = 69
integer y = 1404
integer width = 1390
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 10
integer setstep = 10
end type

type cb_9 from commandbutton within w_ftp_set
integer x = 2071
integer y = 36
integer width = 297
integer height = 100
integer taborder = 210
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Abort"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Abort when processing.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If inv_ftp.of_is_processing() Then
	inv_ftp.of_abort()
End If
end event

type cb_8 from commandbutton within w_ftp_set
integer x = 1678
integer y = 36
integer width = 343
integer height = 100
integer taborder = 170
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Put File"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Send File to FTP.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_localpath 
string ls_romotepath 

ls_localpath = Trim(sle_localpath.text)
ls_romotepath = Trim(sle_remotepath.text)

inv_ftp.of_putfile(ls_localpath, ls_romotepath)
end event

type cb_7 from commandbutton within w_ftp_set
integer x = 1285
integer y = 36
integer width = 343
integer height = 100
integer taborder = 180
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get File"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Get File from FTP.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_localpath 
string ls_romotepath 

ls_localpath = Trim(sle_localpath.text)
ls_romotepath = Trim(sle_remotepath.text)


inv_ftp.of_getfile(ls_localpath, ls_romotepath)



end event

type cb_6 from commandbutton within w_ftp_set
boolean visible = false
integer x = 119
integer y = 1552
integer width = 343
integer height = 100
integer taborder = 140
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "DeleteFile"
end type

event clicked;string ls_romotepath 
ls_romotepath = Trim(sle_remotepath.text)

inv_ftp.of_deletefile(ls_romotepath)
end event

type cb_5 from commandbutton within w_ftp_set
boolean visible = false
integer x = 2071
integer y = 1552
integer width = 343
integer height = 100
integer taborder = 150
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "RemoveDir"
end type

event clicked;string ls_romotepath 
ls_romotepath = Trim(sle_remotepath.text)

inv_ftp.of_removedir(ls_romotepath)
end event

type mle_1 from multilineedit within w_ftp_set
integer x = 69
integer y = 772
integer width = 1390
integer height = 620
integer taborder = 160
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217856
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_ftp_set
boolean visible = false
integer x = 1019
integer y = 1552
integer width = 343
integer height = 100
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "MakeDir"
end type

event clicked;string ls_romotepath 
ls_romotepath = Trim(sle_remotepath.text)

inv_ftp.of_makedir(ls_romotepath)
end event

type cb_3 from commandbutton within w_ftp_set
boolean visible = false
integer x = 581
integer y = 1552
integer width = 343
integer height = 100
integer taborder = 130
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "ListNames"
end type

event clicked;string ls_romotepath 
ls_romotepath = Trim(sle_remotepath.text)

inv_ftp.of_listnames(ls_romotepath)
end event

type cb_2 from commandbutton within w_ftp_set
integer x = 466
integer y = 36
integer width = 347
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Disconnect"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Disconnect for FTP.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

inv_ftp.of_disconnect( )
end event

type cb_dir from commandbutton within w_ftp_set
integer x = 864
integer y = 36
integer width = 370
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "List Directory"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Show FTP Directory.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_romotepath 

ls_romotepath = Trim(sle_remotepath.text)

inv_ftp.of_listdir(ls_romotepath)
end event

type sle_remotepath from singlelineedit within w_ftp_set
integer x = 1883
integer y = 320
integer width = 713
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_localpath from singlelineedit within w_ftp_set
integer x = 1883
integer y = 204
integer width = 713
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_ftp_set
integer x = 1513
integer y = 336
integer width = 357
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Remote Path:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_ftp_set
integer x = 1513
integer y = 228
integer width = 343
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Local Path:"
boolean focusrectangle = false
end type

type sle_port from singlelineedit within w_ftp_set
integer x = 1161
integer y = 552
integer width = 174
integer height = 100
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "21"
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_ftp_set
integer x = 1010
integer y = 564
integer width = 151
integer height = 76
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Port:"
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_ftp_set
integer x = 416
integer y = 440
integer width = 713
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_login from singlelineedit within w_ftp_set
integer x = 416
integer y = 320
integer width = 713
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_hostname from singlelineedit within w_ftp_set
integer x = 416
integer y = 204
integer width = 713
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_ftp_set
integer x = 73
integer y = 564
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Protocol:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ftp_set
integer x = 73
integer y = 448
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Password:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ftp_set
integer x = 73
integer y = 336
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Login:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ftp_set
integer x = 73
integer y = 228
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Hostname:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_ftp_set
integer x = 69
integer y = 36
integer width = 347
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Connect"
boolean default = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Connect to FTP.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_hostname
String ls_port
Int ai_protocol
String ls_login
String ls_password
boolean lb_passive = true
Int i
pointer oldpointer

ls_hostname = Trim(sle_hostname.text)
ls_port = Trim(sle_port.text)
ls_login = Trim(sle_login.text)
ls_password = Trim(sle_password.text)
Choose Case ddlb_protocol.text
	  Case 'FTP'
			ai_protocol = 0
	  Case 'SFTP'
			ai_protocol = 1
	  Case 'FTPS' // FTP+SSL protocol with insecured data channel
			ai_protocol = 2
	  Case 'FTPS + data' //withdata, FTP+SSL protocol with secured data channel. 
			ai_protocol = 3
	  Case 'FTPSimplicit' //FTPSimplicit 4 FTP+SSL implicit on port 990. 
			ai_protocol = 4
			lb_passive = False
 End Choose

oldpointer = SetPointer(HourGlass!)
i = inv_ftp.of_connect(ls_hostname, ls_port, ai_protocol, ls_login, ls_password, lb_passive )
SetPointer(oldpointer)
end event

type ddlb_protocol from dropdownlistbox within w_ftp_set
integer x = 421
integer y = 560
integer width = 571
integer height = 456
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"FTP","SFTP","FTPS","FTPS + data","FTPSimplicit"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//====================================================================
//$<Event>: selectionchanged
//$<Arguments>:
// 	value    integer    index
//$<Return>:  long
//$<Description>: Set Default port.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Choose Case ddlb_protocol.text
	  Case 'FTP'
			sle_port.text = '21'
	  Case 'SFTP'
			sle_port.text = '22'
	  Case 'FTPS' // FTP+SSL protocol with insecured data channel
			sle_port.text = '21'
	  Case 'FTPS + data' //withdata, FTP+SSL protocol with secured data channel. 
			sle_port.text = '21'
	  Case 'FTPSimplicit' //FTPSimplicit 4 FTP+SSL implicit on port 990. 
			sle_port.text = '990'
 End Choose

end event

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.selectitem(2) //SFTP
end event

type gb_1 from groupbox within w_ftp_set
integer x = 18
integer y = 696
integer width = 1463
integer height = 804
integer taborder = 230
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Log"
end type

type gb_2 from groupbox within w_ftp_set
integer x = 1490
integer y = 696
integer width = 1285
integer height = 804
integer taborder = 240
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "FTP Directory"
end type

