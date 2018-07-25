$PBExportHeader$w_library_mod.srw
forward
global type w_library_mod from Window
end type
type cb_2 from commandbutton within w_library_mod
end type
type dw_1 from datawindow within w_library_mod
end type
type st_1 from statictext within w_library_mod
end type
type sle_1 from singlelineedit within w_library_mod
end type
type dw_list from datawindow within w_library_mod
end type
type cb_1 from commandbutton within w_library_mod
end type
end forward

global type w_library_mod from Window
int X=59
int Y=16
int Width=2583
int Height=2580
boolean TitleBar=true
string Title="Library List"
long BackColor=80269524
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
dw_1 dw_1
st_1 st_1
sle_1 sle_1
dw_list dw_list
cb_1 cb_1
end type
global w_library_mod w_library_mod

type variables
String is_library_list_file = "S:\Development\Version 4.current\library_list_intellicred03-03.txt"
end variables

on w_library_mod.create
this.cb_2=create cb_2
this.dw_1=create dw_1
this.st_1=create st_1
this.sle_1=create sle_1
this.dw_list=create dw_list
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.dw_1,&
this.st_1,&
this.sle_1,&
this.dw_list,&
this.cb_1}
end on

on w_library_mod.destroy
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.dw_list)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_library_mod
int X=41
int Y=232
int Width=398
int Height=108
int TabOrder=40
string Text="Import List"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ImportFile( is_library_list_file )
end event

type dw_1 from datawindow within w_library_mod
int X=37
int Y=1560
int Width=2386
int Height=732
int TabOrder=30
string DataObject="d_library_import_list"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type st_1 from statictext within w_library_mod
int X=46
int Y=20
int Width=247
int Height=60
boolean Enabled=false
string Text="Directory"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_library_mod
int X=41
int Y=88
int Width=1696
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_list from datawindow within w_library_mod
int X=37
int Y=376
int Width=2386
int Height=1156
int TabOrder=40
string DataObject="d_library_list"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_library_mod
int X=466
int Y=232
int Width=398
int Height=108
int TabOrder=20
string Text="Get Library List"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_entries
String ls_dir
String ls_library
Integer i
Integer li_rc

li_rc = dw_1.RowCount( )

ls_dir = sle_1.Text

FOR i = 1 TO li_rc
	ls_library = dw_1.GetItemString( I, "library" )
	ls_library = MidA( ls_library, 1, LenA( ls_library ) -1)
	ls_entries = LibraryDirectory( ls_library, DirAll! )
	dw_list.ImportString(ls_Entries)
END FOR
end event

