$PBExportHeader$w_dataview_field_update.srw
forward
global type w_dataview_field_update from Window
end type
type st_1 from statictext within w_dataview_field_update
end type
type cb_3 from commandbutton within w_dataview_field_update
end type
type dw_3 from datawindow within w_dataview_field_update
end type
type dw_2 from datawindow within w_dataview_field_update
end type
type dw_select from datawindow within w_dataview_field_update
end type
type dw_1 from datawindow within w_dataview_field_update
end type
type cb_2 from commandbutton within w_dataview_field_update
end type
type cb_1 from commandbutton within w_dataview_field_update
end type
end forward

global type w_dataview_field_update from Window
int X=1106
int Y=1092
int Width=1979
int Height=864
boolean TitleBar=true
string Title="Data field update"
long BackColor=80269524
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
cb_3 cb_3
dw_3 dw_3
dw_2 dw_2
dw_select dw_select
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_dataview_field_update w_dataview_field_update

type variables
long li_field_id
end variables

on w_dataview_field_update.create
this.st_1=create st_1
this.cb_3=create cb_3
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_select=create dw_select
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_3,&
this.dw_3,&
this.dw_2,&
this.dw_select,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_dataview_field_update.destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_select)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;dw_select.settransobject(sqlca)
dw_select.retrieve()

dw_1.settransobject(sqlca)
end event

type st_1 from statictext within w_dataview_field_update
int X=37
int Y=56
int Width=448
int Height=76
boolean Enabled=false
string Text="1) Select screen"
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

type cb_3 from commandbutton within w_dataview_field_update
int X=32
int Y=476
int Width=297
int Height=84
int TabOrder=50
string Text="About"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;messagebox("About","This function will add data view fields for a praticular screen to data views missing them.") 
end event

type dw_3 from datawindow within w_dataview_field_update
int X=375
int Y=276
int Width=421
int Height=288
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_dataview_field_update
int X=1349
int Y=148
int Width=494
int Height=420
int TabOrder=30
string DataObject="d_oig_data_view"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_select from datawindow within w_dataview_field_update
int X=14
int Y=148
int Width=777
int Height=96
int TabOrder=20
string DataObject="d_sys_fields_only"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;li_field_id = long(data)
end event

type dw_1 from datawindow within w_dataview_field_update
int X=827
int Y=148
int Width=494
int Height=420
int TabOrder=10
string DataObject="d_oig_data_view"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_2 from commandbutton within w_dataview_field_update
int X=32
int Y=276
int Width=297
int Height=84
int TabOrder=60
string Text="2) DV1"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.retrieve(li_field_id)
end event

type cb_1 from commandbutton within w_dataview_field_update
int X=32
int Y=372
int Width=297
int Height=84
int TabOrder=40
string Text="3)Update"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
integer ic
integer r
integer rc
long recid
long fieldid
integer dvid
integer ck = 0

select max(data_view_field_id) into :recid from data_view_fields;

for i = 1 to dw_3.rowcount()
	ck = 0
	dvid = dw_3.getitemnumber(i,"data_view_id")
	for r = 1 to dw_1.rowcount()
		if dw_1.getitemnumber(i,"data_view_id") = dvid then
			exit
		else
			dw_1.RowsCopy (1, 1, primary!, dw_2, 1000, 	primary!)
			dw_2.setitem(dw_2.rowcount(),"data_view_id",dvid)
			dw_2.setitem(dw_2.rowcount(),"data_view_field_id",recid)
		end if
	next
next

if dw_2.rowcount() > 0 then
	dw_2.settransobject(sqlca)
	dw_2.update()
	commit using sqlca;
end if

end event

