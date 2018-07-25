$PBExportHeader$u_tab_test.sru
forward
global type u_tab_test from tab
end type
type tabpage_1 from userobject within u_tab_test
end type
type tabpage_2 from userobject within u_tab_test
end type
type tabpage_3 from userobject within u_tab_test
end type
type tabpage_4 from userobject within u_tab_test
end type
type tabpage_5 from userobject within u_tab_test
end type
type tabpage_6 from userobject within u_tab_test
end type
type tabpage_7 from userobject within u_tab_test
end type
type tabpage_1 from userobject within u_tab_test
end type
type tabpage_2 from userobject within u_tab_test
end type
type tabpage_3 from userobject within u_tab_test
end type
type tabpage_4 from userobject within u_tab_test
end type
type tabpage_5 from userobject within u_tab_test
end type
type tabpage_6 from userobject within u_tab_test
end type
type tabpage_7 from userobject within u_tab_test
end type
end forward

global type u_tab_test from tab
int Width=1979
int Height=192
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=80269524
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
global u_tab_test u_tab_test

on u_tab_test.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7}
end on

on u_tab_test.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

type tabpage_1 from userobject within u_tab_test
int X=18
int Y=100
int Width=1943
int Height=76
long BackColor=67108864
string Text="none"
long TabBackColor=67108864
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

type tabpage_2 from userobject within u_tab_test
int X=18
int Y=100
int Width=1943
int Height=76
long BackColor=67108864
string Text="none"
long TabBackColor=67108864
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

type tabpage_3 from userobject within u_tab_test
int X=18
int Y=100
int Width=1943
int Height=76
long BackColor=67108864
string Text="none"
long TabBackColor=67108864
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

type tabpage_4 from userobject within u_tab_test
int X=18
int Y=100
int Width=1943
int Height=76
long BackColor=67108864
string Text="none"
long TabBackColor=67108864
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

type tabpage_5 from userobject within u_tab_test
int X=18
int Y=100
int Width=1943
int Height=76
string Text="none"
long TabBackColor=1073741824
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

type tabpage_6 from userobject within u_tab_test
int X=18
int Y=100
int Width=1943
int Height=76
string Text="none"
long TabBackColor=1073741824
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

type tabpage_7 from userobject within u_tab_test
int X=18
int Y=100
int Width=1943
int Height=76
string Text="none"
long TabBackColor=1073741824
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

