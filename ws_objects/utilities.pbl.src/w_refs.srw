$PBExportHeader$w_refs.srw
forward
global type w_refs from Window
end type
type cb_5 from commandbutton within w_refs
end type
type cb_4 from commandbutton within w_refs
end type
type cb_3 from commandbutton within w_refs
end type
type cb_2 from commandbutton within w_refs
end type
type dw_1 from datawindow within w_refs
end type
type dw_3 from datawindow within w_refs
end type
type cb_1 from commandbutton within w_refs
end type
type dw_copy from datawindow within w_refs
end type
end forward

global type w_refs from Window
int X=219
int Y=200
int Width=3296
int Height=1972
boolean TitleBar=true
string Title="Reference Update"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
dw_3 dw_3
cb_1 cb_1
dw_copy dw_copy
end type
global w_refs w_refs

on w_refs.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_1=create cb_1
this.dw_copy=create dw_copy
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_1,&
this.dw_3,&
this.cb_1,&
this.dw_copy}
end on

on w_refs.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.dw_copy)
end on

type cb_5 from commandbutton within w_refs
int X=23
int Y=48
int Width=631
int Height=108
int TabOrder=40
string Text="Adjust ref codes in ed"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;update data_view_screen
set reference_field_1 = 89
where screen_id = 6;

update data_view_screen
set reference_field_2 = 82
where screen_id = 6;


end event

type cb_4 from commandbutton within w_refs
int X=2848
int Y=60
int Width=247
int Height=108
int TabOrder=30
string Text="Close"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_refs
int X=1870
int Y=48
int Width=247
int Height=108
int TabOrder=20
boolean Enabled=false
string Text="save"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.update()

commit using sqlca;

messagebox("","Save Complete.")
end event

type cb_2 from commandbutton within w_refs
int X=1211
int Y=48
int Width=526
int Height=108
int TabOrder=10
boolean Enabled=false
string Text="update references"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long r
integer r2
integer i
integer rcount
integer rcount2
integer rcount3
long recid
long pracid
integer facilid
integer tableid
long ll_ref
string ls_ref1
string ls_ref2
string fullref
long recdata
long recver
integer check = 0
string ls_ref
long addr_id

rcount = dw_1.rowcount()

for r = 1 to rcount
		
			dw_1.scrolltorow(r)
			fullref = ""
			tableid = dw_1.getitemnumber(r,"data_view_screen_table_id")
			recid = dw_1.getitemnumber(r,"rec_id")
			choose case tableid
		
				case 8//
					dw_3.dataobject = "d_x_education"
					dw_3.settransobject(sqlca)
					dw_3.retrieve(recid)
					if dw_3.rowcount() < 1 then continue
	
				case else
					continue
			end choose
			
			
				choose case tableid
		
				case 8//
					
		
					ls_ref2 = dw_3.getitemstring(1,"code")
					ls_ref1 = dw_3.getitemstring(1,"entity_name")
					addr_id = dw_3.getitemnumber(1,"school_code")
		
				case else
					continue
			end choose
	
		if isnull(ls_ref1) then ls_ref1 = " "
		if isnull(ls_ref2) then ls_ref2 = " "
		fullref = ls_ref1 + " - " + ls_ref2	
		dw_1.setitem(r,"reference_value",fullref)
		dw_1.setitem(r,"address_lookup_code",addr_id)
//		if dw_1.getitemstring(r,"reference_value",primary!,true) <> dw_1.getitemstring(r,"reference_value",primary!,false) then
//			dw_1.rowscopy(1,rcount,primary!,dw_3,1000000,Primary!)
//		end if
		//	messagebox("fullref",fullref)

	
			
		
	
next
//dw_1.rowscopy(1,rcount,DataModified!,dw_3,1000000,Primary!)
cb_3.enabled = true

end event

type dw_1 from datawindow within w_refs
int X=41
int Y=536
int Width=3200
int Height=1304
int TabOrder=60
string DataObject="d_verif_info2"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_3 from datawindow within w_refs
int X=23
int Y=192
int Width=3159
int Height=300
int TabOrder=50
string DataObject="d_x_education"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_refs
int X=718
int Y=52
int Width=265
int Height=108
int TabOrder=40
string Text="Retrieve"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.settransobject(sqlca)
dw_1.retrieve()

//dw_3.settransobject(sqlca)

cb_2.enabled = true

end event

type dw_copy from datawindow within w_refs
int X=41
int Y=1380
int Width=91
int Height=60
int TabOrder=70
string DataObject="d_verif_info2"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

