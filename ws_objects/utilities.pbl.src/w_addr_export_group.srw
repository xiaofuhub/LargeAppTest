$PBExportHeader$w_addr_export_group.srw
forward
global type w_addr_export_group from window
end type
type sle_1 from singlelineedit within w_addr_export_group
end type
type cb_7 from commandbutton within w_addr_export_group
end type
type cb_6 from commandbutton within w_addr_export_group
end type
type cb_5 from commandbutton within w_addr_export_group
end type
type dw_2 from datawindow within w_addr_export_group
end type
type dw_1 from datawindow within w_addr_export_group
end type
type cb_4 from commandbutton within w_addr_export_group
end type
type cb_3 from commandbutton within w_addr_export_group
end type
type cb_2 from commandbutton within w_addr_export_group
end type
type cb_1 from commandbutton within w_addr_export_group
end type
end forward

global type w_addr_export_group from window
integer x = 123
integer y = 112
integer width = 3451
integer height = 2200
boolean titlebar = true
string title = "Group Location from Address Generator"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
sle_1 sle_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
dw_2 dw_2
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_addr_export_group w_addr_export_group

on w_addr_export_group.create
this.sle_1=create sle_1
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.sle_1,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.dw_2,&
this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_addr_export_group.destroy
destroy(this.sle_1)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;SQLCA.DBMS="ODBC"
SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

CONNECT USING SQLCA;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Not Logged In", "Login Failed!")
ELSE
	MESSAGEBOX("","LOGIN OK")
END IF


end event

event close;disCONNECT USING SQLCA;
end event

type sle_1 from singlelineedit within w_addr_export_group
integer x = 809
integer y = 976
integer width = 1097
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_7 from commandbutton within w_addr_export_group
integer x = 169
integer y = 964
integer width = 512
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Find file to import"
end type

event clicked;string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value = 1 THEN
	sle_1.text = docname
END IF
end event

type cb_6 from commandbutton within w_addr_export_group
integer x = 2290
integer y = 964
integer width = 247
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;dw_2.settransobject(sqlca)
dw_2.update()

commit using sqlca;
end event

type cb_5 from commandbutton within w_addr_export_group
integer x = 2002
integer y = 968
integer width = 247
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import"
end type

event clicked;integer rec
integer i
integer rc

select max(rec_id)
into :rec 
from group_practice;

if isnull(rec) or rec < 1 then rec = 1

if sle_1.text = "" then
	messagebox("No File","Please search for file first.")
	return
end if

rc = dw_2.ImportFile ( sle_1.text )

for i = 1 to rc
	rec++
	dw_2.setitem(i,"rec_id",rec)
next
end event

type dw_2 from datawindow within w_addr_export_group
integer x = 101
integer y = 1132
integer width = 3218
integer height = 796
integer taborder = 90
string dataobject = "d_aeg_grp_import_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_1 from datawindow within w_addr_export_group
integer x = 82
integer y = 204
integer width = 3031
integer height = 668
integer taborder = 50
string dataobject = "d_aeg_address_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_addr_export_group
integer x = 795
integer y = 44
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Export"
end type

event clicked;if dw_1.rowcount() < 1 then
	messagebox("No Data","Nothing to export. Retrieve address info first.")
	return
end if


messagebox("Export records","Save as an excel file. When modification of the records is complete, save the excel file as a text file.  Then use the import function of this utility")

gnv_dw.of_SaveAs(dw_1,"",excel5!,true)//.SaveAs( "", excel5!, true ) Modify by Evan 05.11.2010
end event

type cb_3 from commandbutton within w_addr_export_group
integer x = 3122
integer y = 36
integer width = 274
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_2 from commandbutton within w_addr_export_group
integer x = 187
integer y = 40
integer width = 526
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Get address info"
end type

event clicked;
dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_1 from commandbutton within w_addr_export_group
integer x = 3131
integer y = 164
integer width = 265
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Click retrieve to get address records. Click export to save as excel file. When modification of the records is complete, save the excel file as a text file.  Then use the import function of this utility. Find the saved text file, click import to create Group locations.")
end event

