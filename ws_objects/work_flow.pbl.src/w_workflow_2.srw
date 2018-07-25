$PBExportHeader$w_workflow_2.srw
forward
global type w_workflow_2 from window
end type
type st_10 from statictext within w_workflow_2
end type
type st_9 from statictext within w_workflow_2
end type
type cbx_2 from checkbox within w_workflow_2
end type
type cbx_4 from checkbox within w_workflow_2
end type
type tab_1 from tab within w_workflow_2
end type
type tabpage_1 from userobject within tab_1
end type
type rb_f from radiobutton within tabpage_1
end type
type rb_s from radiobutton within tabpage_1
end type
type st_a from statictext within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_2 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
rb_f rb_f
rb_s rb_s
st_a st_a
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type rb_f2 from radiobutton within tabpage_2
end type
type rb_s3 from radiobutton within tabpage_2
end type
type st_a3 from statictext within tabpage_2
end type
type dw_1 from datawindow within tabpage_2
end type
type cb_4 from commandbutton within tabpage_2
end type
type cb_3 from commandbutton within tabpage_2
end type
type dw_23 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
rb_f2 rb_f2
rb_s3 rb_s3
st_a3 st_a3
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
dw_23 dw_23
end type
type tabpage_3 from userobject within tab_1
end type
type cb_7 from commandbutton within tabpage_3
end type
type cb_6 from commandbutton within tabpage_3
end type
type cb_5 from commandbutton within tabpage_3
end type
type rte_1 from richtextedit within tabpage_3
end type
type ddlb_3 from dropdownlistbox within tabpage_3
end type
type sle_6 from singlelineedit within tabpage_3
end type
type sle_5 from singlelineedit within tabpage_3
end type
type sle_4 from singlelineedit within tabpage_3
end type
type sle_3 from singlelineedit within tabpage_3
end type
type st_8 from statictext within tabpage_3
end type
type st_7 from statictext within tabpage_3
end type
type st_6 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
rte_1 rte_1
ddlb_3 ddlb_3
sle_6 sle_6
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
st_8 st_8
st_7 st_7
st_6 st_6
end type
type tabpage_4 from userobject within tab_1
end type
type cb_3231 from commandbutton within tabpage_4
end type
type cb_12121 from commandbutton within tabpage_4
end type
type cb_2121 from commandbutton within tabpage_4
end type
type st_1111 from statictext within tabpage_4
end type
type rte_33 from richtextedit within tabpage_4
end type
type ddlb_11 from dropdownlistbox within tabpage_4
end type
type st_22 from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
cb_3231 cb_3231
cb_12121 cb_12121
cb_2121 cb_2121
st_1111 st_1111
rte_33 rte_33
ddlb_11 ddlb_11
st_22 st_22
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tab_1 from tab within w_workflow_2
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type sle_2 from singlelineedit within w_workflow_2
end type
type st_5 from statictext within w_workflow_2
end type
type cbx_1 from checkbox within w_workflow_2
end type
type ddlb_2 from dropdownlistbox within w_workflow_2
end type
type st_4 from statictext within w_workflow_2
end type
type st_2 from statictext within w_workflow_2
end type
type sle_1 from singlelineedit within w_workflow_2
end type
type st_1 from statictext within w_workflow_2
end type
type ddlb_1 from dropdownlistbox within w_workflow_2
end type
end forward

global type w_workflow_2 from window
integer x = 27
integer y = 4
integer width = 3200
integer height = 2080
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
st_10 st_10
st_9 st_9
cbx_2 cbx_2
cbx_4 cbx_4
tab_1 tab_1
sle_2 sle_2
st_5 st_5
cbx_1 cbx_1
ddlb_2 ddlb_2
st_4 st_4
st_2 st_2
sle_1 sle_1
st_1 st_1
ddlb_1 ddlb_1
end type
global w_workflow_2 w_workflow_2

on w_workflow_2.create
this.st_10=create st_10
this.st_9=create st_9
this.cbx_2=create cbx_2
this.cbx_4=create cbx_4
this.tab_1=create tab_1
this.sle_2=create sle_2
this.st_5=create st_5
this.cbx_1=create cbx_1
this.ddlb_2=create ddlb_2
this.st_4=create st_4
this.st_2=create st_2
this.sle_1=create sle_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.Control[]={this.st_10,&
this.st_9,&
this.cbx_2,&
this.cbx_4,&
this.tab_1,&
this.sle_2,&
this.st_5,&
this.cbx_1,&
this.ddlb_2,&
this.st_4,&
this.st_2,&
this.sle_1,&
this.st_1,&
this.ddlb_1}
end on

on w_workflow_2.destroy
destroy(this.st_10)
destroy(this.st_9)
destroy(this.cbx_2)
destroy(this.cbx_4)
destroy(this.tab_1)
destroy(this.sle_2)
destroy(this.st_5)
destroy(this.cbx_1)
destroy(this.ddlb_2)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.ddlb_1)
end on

event open;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-12-05 By: Cao YongWang
//$<reason> 
//SQLCA.DBMS="ODBC"
//SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=dba;PWD=sql',DelimitIdentifier='No'"
Choose Case gs_dbType
	Case 'ASA'
		SQLCA.DBMS="ODBC"
		SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=dba;PWD=sql',DelimitIdentifier='No'"
		SQLCA.autocommit = True
	Case 'SQL'
		SQLCA.DBMS="ODBC"
		SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=sa;PWD=',DelimitIdentifier='No'"
		SQLCA.autocommit = True
End Choose
//---------------------------- APPEON END ----------------------------

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
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2007.08.31 By: Jack
	//$<reason> Fix a defect.
	/*
	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
	*/
	MessageBox("Login", "Initial Login Failed!  Check your ODBC configuration")
	//---------------------------- APPEON END ----------------------------
	Return -1
END IF

Return 1
end event

type st_10 from statictext within w_workflow_2
integer x = 1851
integer y = 512
integer width = 105
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "And"
boolean focusrectangle = false
end type

type st_9 from statictext within w_workflow_2
integer x = 1851
integer y = 288
integer width = 105
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "And"
boolean focusrectangle = false
end type

type cbx_2 from checkbox within w_workflow_2
integer x = 1957
integer y = 280
integer width = 1102
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Run a custom Modification SQL Statement"
end type

type cbx_4 from checkbox within w_workflow_2
integer x = 1957
integer y = 500
integer width = 1202
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Results from a custom query must be evaluated "
end type

type tab_1 from tab within w_workflow_2
integer x = 78
integer y = 640
integer width = 3035
integer height = 1256
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
alignment alignment = right!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2999
integer height = 1140
long backcolor = 33551856
string text = "Create Action Item"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
rb_f rb_f
rb_s rb_s
st_a st_a
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
end type

on tabpage_1.create
this.rb_f=create rb_f
this.rb_s=create rb_s
this.st_a=create st_a
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.Control[]={this.rb_f,&
this.rb_s,&
this.st_a,&
this.cb_2,&
this.cb_1,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.rb_f)
destroy(this.rb_s)
destroy(this.st_a)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
end on

type rb_f from radiobutton within tabpage_1
integer x = 1541
integer y = 12
integer width = 695
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Payor/Hospital Enrollment"
end type

type rb_s from radiobutton within tabpage_1
integer x = 2240
integer y = 12
integer width = 745
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Primary Source Verificaction "
boolean righttoleft = true
end type

type st_a from statictext within tabpage_1
integer x = 677
integer y = 20
integer width = 864
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "What type of workflow action item?"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within tabpage_1
integer x = 279
integer y = 8
integer width = 247
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_1 from commandbutton within tabpage_1
integer x = 18
integer y = 8
integer width = 247
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type dw_2 from datawindow within tabpage_1
integer x = 9
integer y = 116
integer width = 2907
integer height = 516
integer taborder = 50
boolean titlebar = true
string title = "Action Items to Modify"
string dataobject = "d_ia_net_dev_action_items"
boolean livescroll = true
end type

event constructor;This.SetTransObject( sqlca )
This.InsertRow( 0 )
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2999
integer height = 1140
long backcolor = 33551856
string text = "Modify Action Items"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
rb_f2 rb_f2
rb_s3 rb_s3
st_a3 st_a3
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
dw_23 dw_23
end type

on tabpage_2.create
this.rb_f2=create rb_f2
this.rb_s3=create rb_s3
this.st_a3=create st_a3
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_23=create dw_23
this.Control[]={this.rb_f2,&
this.rb_s3,&
this.st_a3,&
this.dw_1,&
this.cb_4,&
this.cb_3,&
this.dw_23}
end on

on tabpage_2.destroy
destroy(this.rb_f2)
destroy(this.rb_s3)
destroy(this.st_a3)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_23)
end on

type rb_f2 from radiobutton within tabpage_2
integer x = 2286
integer y = 12
integer width = 745
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Payor/Hospital Enrollment"
end type

type rb_s3 from radiobutton within tabpage_2
integer x = 1541
integer y = 12
integer width = 741
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Primary Source Verificaction "
boolean righttoleft = true
end type

type st_a3 from statictext within tabpage_2
integer x = 681
integer y = 20
integer width = 859
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "What type of workflow action item?"
boolean focusrectangle = false
end type

type dw_1 from datawindow within tabpage_2
integer x = 9
integer y = 632
integer width = 2907
integer height = 484
integer taborder = 50
boolean titlebar = true
string title = "Modify them to look like this"
string dataobject = "d_ia_net_dev_action_items"
boolean livescroll = true
end type

event constructor;This.SetTransObject( sqlca )
This.InsertRow( 0 )
end event

type cb_4 from commandbutton within tabpage_2
integer x = 283
integer y = 12
integer width = 247
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_3 from commandbutton within tabpage_2
integer x = 18
integer y = 12
integer width = 247
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type dw_23 from datawindow within tabpage_2
integer x = 9
integer y = 100
integer width = 2907
integer height = 516
integer taborder = 50
boolean titlebar = true
string title = "If there is an Action Item like this"
string dataobject = "d_ia_net_dev_action_items"
boolean livescroll = true
end type

event constructor;This.SetTransObject( sqlca )
This.InsertRow( 0 )
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2999
integer height = 1140
long backcolor = 33551856
string text = "Evaluation Query"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
rte_1 rte_1
ddlb_3 ddlb_3
sle_6 sle_6
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
st_8 st_8
st_7 st_7
st_6 st_6
end type

on tabpage_3.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.rte_1=create rte_1
this.ddlb_3=create ddlb_3
this.sle_6=create sle_6
this.sle_5=create sle_5
this.sle_4=create sle_4
this.sle_3=create sle_3
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.rte_1,&
this.ddlb_3,&
this.sle_6,&
this.sle_5,&
this.sle_4,&
this.sle_3,&
this.st_8,&
this.st_7,&
this.st_6}
end on

on tabpage_3.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.rte_1)
destroy(this.ddlb_3)
destroy(this.sle_6)
destroy(this.sle_5)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
end on

type cb_7 from commandbutton within tabpage_3
integer x = 581
integer y = 644
integer width = 251
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_6 from commandbutton within tabpage_3
integer x = 306
integer y = 644
integer width = 251
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_5 from commandbutton within tabpage_3
integer x = 37
integer y = 644
integer width = 251
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test SQL"
end type

type rte_1 from richtextedit within tabpage_3
integer x = 37
integer y = 208
integer width = 1509
integer height = 416
integer taborder = 80
borderstyle borderstyle = stylelowered!
end type

type ddlb_3 from dropdownlistbox within tabpage_3
integer x = 626
integer y = 36
integer width = 910
integer height = 228
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Prac_id","Facility_id","App_id","Lookup_code"}
borderstyle borderstyle = stylelowered!
end type

type sle_6 from singlelineedit within tabpage_3
integer x = 1586
integer y = 528
integer width = 1289
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_5 from singlelineedit within tabpage_3
integer x = 1586
integer y = 420
integer width = 1289
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_4 from singlelineedit within tabpage_3
integer x = 1586
integer y = 312
integer width = 1289
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within tabpage_3
integer x = 1586
integer y = 204
integer width = 1289
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within tabpage_3
integer x = 1586
integer y = 136
integer width = 379
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Value Range"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_3
integer x = 37
integer y = 36
integer width = 599
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Retrieval Argument Data:"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_3
integer x = 32
integer y = 140
integer width = 407
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Statement"
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2999
integer height = 1140
long backcolor = 33551856
string text = "Modification Query"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_3231 cb_3231
cb_12121 cb_12121
cb_2121 cb_2121
st_1111 st_1111
rte_33 rte_33
ddlb_11 ddlb_11
st_22 st_22
end type

on tabpage_4.create
this.cb_3231=create cb_3231
this.cb_12121=create cb_12121
this.cb_2121=create cb_2121
this.st_1111=create st_1111
this.rte_33=create rte_33
this.ddlb_11=create ddlb_11
this.st_22=create st_22
this.Control[]={this.cb_3231,&
this.cb_12121,&
this.cb_2121,&
this.st_1111,&
this.rte_33,&
this.ddlb_11,&
this.st_22}
end on

on tabpage_4.destroy
destroy(this.cb_3231)
destroy(this.cb_12121)
destroy(this.cb_2121)
destroy(this.st_1111)
destroy(this.rte_33)
destroy(this.ddlb_11)
destroy(this.st_22)
end on

type cb_3231 from commandbutton within tabpage_4
integer x = 581
integer y = 636
integer width = 251
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_12121 from commandbutton within tabpage_4
integer x = 306
integer y = 636
integer width = 251
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_2121 from commandbutton within tabpage_4
integer x = 37
integer y = 636
integer width = 251
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test SQL"
end type

type st_1111 from statictext within tabpage_4
integer x = 32
integer y = 140
integer width = 411
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Statement"
boolean focusrectangle = false
end type

type rte_33 from richtextedit within tabpage_4
integer x = 37
integer y = 208
integer width = 1509
integer height = 412
integer taborder = 90
borderstyle borderstyle = stylelowered!
end type

type ddlb_11 from dropdownlistbox within tabpage_4
integer x = 635
integer y = 36
integer width = 910
integer height = 228
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Prac_id","Facility_id","App_id","Lookup_code"}
borderstyle borderstyle = stylelowered!
end type

type st_22 from statictext within tabpage_4
integer x = 37
integer y = 36
integer width = 613
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Retrieval Argument Data:"
boolean focusrectangle = false
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2999
integer height = 1140
long backcolor = 33551856
string text = "Scheduled Event"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
end type

type sle_2 from singlelineedit within w_workflow_2
integer x = 1618
integer y = 80
integer width = 1472
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Credentialing"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_workflow_2
integer x = 1614
integer y = 20
integer width = 590
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Work Flow Action Name"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_workflow_2
integer x = 741
integer y = 1472
integer width = 1097
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 10789024
string text = "Modify data even if field allready has data in it?"
end type

type ddlb_2 from dropdownlistbox within w_workflow_2
integer x = 82
integer y = 492
integer width = 1760
integer height = 1168
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Modification to an existing Application Status Action Item","Modification to an existing PSV Action Item","Data Entry Complete button clicked","Application Audit Complete button clicked","Practitioner Credentialing Data being modified","Pracitioner affiliated with a new Payor/Hospital","A specific date based on a field within IntelliApp/IntelliCred","New document scanned into practitioner folder","New Practitioner entered in the system","All PSV  Verifications Completed","Scheduled Event","Manual"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_workflow_2
integer x = 82
integer y = 428
integer width = 1408
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "What will trigger this work flow action to happen?"
boolean focusrectangle = false
end type

type st_2 from statictext within w_workflow_2
integer x = 82
integer y = 216
integer width = 1138
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "What do you want this workflow action to do?"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_workflow_2
integer x = 82
integer y = 80
integer width = 1472
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Credentialing"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_workflow_2
integer x = 82
integer y = 20
integer width = 421
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Work Flow Name"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_workflow_2
integer x = 82
integer y = 280
integer width = 1760
integer height = 528
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean vscrollbar = true
string item[] = {"Create NEW action Item(s)","MODIFY existing action item(s)","Create  NEW action item(s) and MODIFY existing action item(s)"}
borderstyle borderstyle = stylelowered!
end type

