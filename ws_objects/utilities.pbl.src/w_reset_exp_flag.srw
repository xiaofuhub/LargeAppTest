$PBExportHeader$w_reset_exp_flag.srw
forward
global type w_reset_exp_flag from Window
end type
type cb_5 from commandbutton within w_reset_exp_flag
end type
type cb_4 from commandbutton within w_reset_exp_flag
end type
type cb_8 from commandbutton within w_reset_exp_flag
end type
type cb_3 from commandbutton within w_reset_exp_flag
end type
type cb_2 from commandbutton within w_reset_exp_flag
end type
type cb_1 from commandbutton within w_reset_exp_flag
end type
type dw_basic from datawindow within w_reset_exp_flag
end type
type dw_links from datawindow within w_reset_exp_flag
end type
type dw_1 from datawindow within w_reset_exp_flag
end type
end forward

global type w_reset_exp_flag from Window
int X=123
int Y=112
int Width=2053
int Height=424
boolean TitleBar=true
string Title="Reset exp cred flags set at 2"
long BackColor=79680469
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
cb_5 cb_5
cb_4 cb_4
cb_8 cb_8
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_basic dw_basic
dw_links dw_links
dw_1 dw_1
end type
global w_reset_exp_flag w_reset_exp_flag

type variables
integer ii_row
end variables

on w_reset_exp_flag.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_8=create cb_8
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_basic=create dw_basic
this.dw_links=create dw_links
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_8,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_basic,&
this.dw_links,&
this.dw_1}
end on

on w_reset_exp_flag.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_8)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_basic)
destroy(this.dw_links)
destroy(this.dw_1)
end on

event close;disCONNECT USING SQLCA;
end event

type cb_5 from commandbutton within w_reset_exp_flag
int X=46
int Y=188
int Width=777
int Height=84
int TabOrder=20
string Text="Delete duplicate exp letters"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
integer rc
integer check



dw_1.settransobject(sqlca)
rc = dw_1.retrieve()
cb_8.enabled = true
messagebox("rc",rc)
for i = rc to 1 step - 1
	if i > 1 then
		if dw_1.getitemnumber(i,"verif_info_rec_id") = dw_1.getitemnumber(i - 1,"verif_info_rec_id") then
			dw_1.deleterow(i)
		end if
	end if
next

dw_1.update()
commit using sqlca;
messagebox("rc",dw_basic.rowcount())
end event

type cb_4 from commandbutton within w_reset_exp_flag
int X=46
int Y=68
int Width=777
int Height=84
int TabOrder=80
string Text="Delete all exp cred letters"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;delete from verif_info 
where active_status = 1 and exp_credential_flag = 1 and screen_id <> 1 and response_code is null and first_sent is null;
end event

type cb_8 from commandbutton within w_reset_exp_flag
int X=1166
int Y=68
int Width=247
int Height=84
int TabOrder=30
boolean Enabled=false
string Text="2)run"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long i
integer l
long rc
long recid
long meth
integer lc
integer cnt = 0

//messagebox("",meth)


rc = dw_basic.rowcount()

for i = 1 to rc
	recid = dw_basic.getitemnumber(i,"verif_info_rec_id")
	dw_links.settransobject(sqlca)
	cnt = dw_links.retrieve(recid)

	if  isnull(cnt) or cnt < 1 then  
 		dw_basic.setitem(i,"exp_credential_flag",0)
	end if
next
	dw_basic.update()
	commit using sqlca;

	
messagebox("","Finished")
end event

type cb_3 from commandbutton within w_reset_exp_flag
int X=1733
int Y=64
int Width=274
int Height=84
int TabOrder=60
string Text="Quit"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CLOSE(PARENT)
end event

type cb_2 from commandbutton within w_reset_exp_flag
int X=841
int Y=68
int Width=306
int Height=84
int TabOrder=10
string Text="1)retrieve"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
integer rc
integer check



dw_basic.settransobject(sqlca)
rc = dw_basic.retrieve()
cb_8.enabled = true
messagebox("rc",rc)
for i = rc to 1 step - 1
	if i > 1 then
		if dw_basic.getitemnumber(i,"verif_info_rec_id") = dw_basic.getitemnumber(i - 1,"verif_info_rec_id") then
			dw_basic.deleterow(i - 1)
		end if
	end if
next
messagebox("rc",dw_basic.rowcount())
end event

type cb_1 from commandbutton within w_reset_exp_flag
int X=1440
int Y=64
int Width=265
int Height=84
int TabOrder=70
string Text="About"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;messagebox("To operate this program :","Click retrieve.  Click run. Program will check for all normal verifications for a exp_cred flag of 2 (means exp cred letter had been generated.) For each record it will check to see if there is another record with a flag of 1 or 0; if not the original flag will be reset to 0 ")
end event

type dw_basic from datawindow within w_reset_exp_flag
int X=1285
int Y=156
int Width=69
int Height=76
int TabOrder=40
boolean Visible=false
string DataObject="d_verifs_w_2_flag"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_links from datawindow within w_reset_exp_flag
int X=1056
int Y=52
int Width=146
int Height=68
int TabOrder=50
boolean Visible=false
string DataObject="d_verifs_child_of_2_flag"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_reset_exp_flag
int X=1033
int Y=168
int Width=151
int Height=76
int TabOrder=30
boolean Visible=false
string DataObject="d_verifs_child_of_2_flag_at_1"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

