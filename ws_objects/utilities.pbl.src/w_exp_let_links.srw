$PBExportHeader$w_exp_let_links.srw
forward
global type w_exp_let_links from Window
end type
type cb_8 from commandbutton within w_exp_let_links
end type
type dw_links from datawindow within w_exp_let_links
end type
type cb_3 from commandbutton within w_exp_let_links
end type
type cb_2 from commandbutton within w_exp_let_links
end type
type cb_1 from commandbutton within w_exp_let_links
end type
type dw_basic from datawindow within w_exp_let_links
end type
end forward

global type w_exp_let_links from Window
int X=123
int Y=112
int Width=1554
int Height=404
boolean TitleBar=true
string Title="Adjust adr links to only 1 exp cred let per prac"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
cb_8 cb_8
dw_links dw_links
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_basic dw_basic
end type
global w_exp_let_links w_exp_let_links

type variables
integer ii_row
end variables

on w_exp_let_links.create
this.cb_8=create cb_8
this.dw_links=create dw_links
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_basic=create dw_basic
this.Control[]={this.cb_8,&
this.dw_links,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_basic}
end on

on w_exp_let_links.destroy
destroy(this.cb_8)
destroy(this.dw_links)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_basic)
end on

event close;disCONNECT USING SQLCA;
end event

type cb_8 from commandbutton within w_exp_let_links
int X=553
int Y=60
int Width=247
int Height=108
int TabOrder=20
string Text="2)run"
int TextSize=-10
int Weight=400
string FaceName="Arial"
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
	recid = dw_basic.getitemnumber(i,"prac_id")
	dw_links.settransobject(sqlca)
	lc = dw_links.retrieve(recid)
	cnt = 0
	for l  = 2 to lc  
 		dw_links.setitem(l,"exp_letters",0)
	next
	dw_links.update()
	commit using sqlca;

next	
messagebox("","Finished")
end event

type dw_links from datawindow within w_exp_let_links
int X=645
int Y=84
int Width=146
int Height=68
int TabOrder=40
string DataObject="d_addr_links_prac"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_exp_let_links
int X=1029
int Y=52
int Width=274
int Height=108
int TabOrder=50
string Text="Quit"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CLOSE(PARENT)
end event

type cb_2 from commandbutton within w_exp_let_links
int X=133
int Y=56
int Width=306
int Height=108
int TabOrder=10
string Text="1)retrieve"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
//
//if rb_brd.checked = true then
//	dw_1.dataobject = "d_board_list"
//elseif rb_dea.checked = true then
//	dw_1.dataobject = "d_dea_list"
//elseif rb_ins.checked = true then
//	dw_1.dataobject = "d_ins_list"
//elseif rb_lisc.checked = true then
//	dw_1.dataobject = "d_lisc_list"
//end if
//	
//	
dw_basic.settransobject(sqlca)
dw_basic.retrieve()
end event

type cb_1 from commandbutton within w_exp_let_links
int X=1029
int Y=184
int Width=265
int Height=72
int TabOrder=60
string Text="About"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;messagebox("To operate this program :","Click retrieve. Click run.  Program will reset address links so that there is only 1 exp cred link for each practitioner.")
end event

type dw_basic from datawindow within w_exp_let_links
int X=155
int Y=68
int Width=233
int Height=72
int TabOrder=30
string DataObject="d_basic"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

