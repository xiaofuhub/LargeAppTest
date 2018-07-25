$PBExportHeader$w_get_filter_nameold.srw
forward
global type w_get_filter_nameold from w_get_lookup_name
end type
end forward

global type w_get_filter_nameold from w_get_lookup_name
int Width=1719
int Height=384
boolean TitleBar=true
string Title="Filter Name"
long BackColor=80269524
end type
global w_get_filter_nameold w_get_filter_nameold

on w_get_filter_nameold.create
call super::create
end on

on w_get_filter_nameold.destroy
call super::destroy
end on

event open;call super::open;string mes

mes = message.stringparm

if mes = "A" then
	st_1.text = "New Filter Name:"
elseif mes = "S" then
	st_1.text = "Save Filter As:"
elseif mes = "B" then
	st_1.text = "New Batch Name:"
	this.title = "Batch Name"
//elseif mes = "S" then
//	st_1.text = "Save Batch As:"
end if
end event

type st_1 from w_get_lookup_name`st_1 within w_get_filter_nameold
int X=110
int Y=32
boolean BringToTop=true
string Text="Filter name"
end type

type sle_1 from w_get_lookup_name`sle_1 within w_get_filter_nameold
int X=110
int Y=96
int Width=1097
int Height=96
boolean BringToTop=true
end type

type cb_1 from w_get_lookup_name`cb_1 within w_get_filter_nameold
int X=1243
int Y=96
boolean BringToTop=true
boolean Default=true
end type

event cb_1::clicked;String ls_retval


ls_retval = sle_1.Text 


CloseWithReturn(Parent, ls_retval )
end event

type gb_1 from w_get_lookup_name`gb_1 within w_get_filter_nameold
boolean Visible=false
end type

type rb_a from w_get_lookup_name`rb_a within w_get_filter_nameold
boolean Visible=false
boolean BringToTop=true
end type

type rb_c from w_get_lookup_name`rb_c within w_get_filter_nameold
boolean Visible=false
boolean BringToTop=true
end type

type cb_2 from w_get_lookup_name`cb_2 within w_get_filter_nameold
int X=846
int Y=348
boolean BringToTop=true
end type

type cb_3 from w_get_lookup_name`cb_3 within w_get_filter_nameold
int X=1243
int Y=208
boolean BringToTop=true
end type

