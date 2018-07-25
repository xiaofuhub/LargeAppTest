$PBExportHeader$w_test.srw
forward
global type w_test from Window
end type
type st_3 from statictext within w_test
end type
type mle_1 from multilineedit within w_test
end type
type lb_2 from listbox within w_test
end type
type st_2 from statictext within w_test
end type
type st_1 from statictext within w_test
end type
type lb_1 from listbox within w_test
end type
type pb_7 from picturebutton within w_test
end type
type pb_6 from picturebutton within w_test
end type
type pb_5 from picturebutton within w_test
end type
type pb_4 from picturebutton within w_test
end type
type pb_3 from picturebutton within w_test
end type
type pb_2 from picturebutton within w_test
end type
type pb_1 from picturebutton within w_test
end type
end forward

global type w_test from Window
int X=1056
int Y=456
int Width=887
int Height=2020
boolean TitleBar=true
string Title="Untitled"
long BackColor=15780518
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_3 st_3
mle_1 mle_1
lb_2 lb_2
st_2 st_2
st_1 st_1
lb_1 lb_1
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
end type
global w_test w_test

on w_test.create
this.st_3=create st_3
this.mle_1=create mle_1
this.lb_2=create lb_2
this.st_2=create st_2
this.st_1=create st_1
this.lb_1=create lb_1
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={this.st_3,&
this.mle_1,&
this.lb_2,&
this.st_2,&
this.st_1,&
this.lb_1,&
this.pb_7,&
this.pb_6,&
this.pb_5,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1}
end on

on w_test.destroy
destroy(this.st_3)
destroy(this.mle_1)
destroy(this.lb_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.lb_1)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
end on

type st_3 from statictext within w_test
int X=41
int Y=72
int Width=421
int Height=64
boolean Enabled=false
string Text="Practitioner Search"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=15780518
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_1 from multilineedit within w_test
int X=41
int Y=136
int Width=745
int Height=224
int TabOrder=20
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_2 from listbox within w_test
int X=41
int Y=440
int Width=741
int Height=356
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Add/Modify Credentialing Data",&
"Generate Credentialing Form",&
"Track Expiring Credentials",&
"Track Application Process"}
end type

type st_2 from statictext within w_test
int X=46
int Y=376
int Width=741
int Height=64
boolean Enabled=false
string Text="Practitioner"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_test
int X=46
int Y=932
int Width=741
int Height=64
boolean Enabled=false
string Text="Quick Reports"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_1 from listbox within w_test
int X=46
int Y=992
int Width=741
int Height=356
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Expiring Credentials",&
"Application Tracking 1",&
"Application Tracking 2",&
"Provider Profile",&
"Missing Information"}
end type

type pb_7 from picturebutton within w_test
int X=50
int Y=1344
int Width=741
int Height=92
int TabOrder=50
string Text="Run Reports"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_6 from picturebutton within w_test
int X=1106
int Y=1088
int Width=818
int Height=92
int TabOrder=40
string Text="Track Required Data/Hard Copies"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_5 from picturebutton within w_test
int X=2286
int Y=392
int Width=677
int Height=92
int TabOrder=30
string Text="Track Expiring Credentials"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_4 from picturebutton within w_test
int X=869
int Y=396
int Width=677
int Height=92
int TabOrder=80
string Text="Print Applications"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_3 from picturebutton within w_test
int X=1573
int Y=392
int Width=677
int Height=92
int TabOrder=90
string Text="Track Applications"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_2 from picturebutton within w_test
int X=1106
int Y=860
int Width=677
int Height=92
int TabOrder=20
string Text="Add/Modify Practitioner"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_1 from picturebutton within w_test
int X=1253
int Y=232
int Width=677
int Height=92
int TabOrder=10
string Text="Practitioner"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

