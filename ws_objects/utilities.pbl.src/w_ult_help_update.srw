$PBExportHeader$w_ult_help_update.srw
forward
global type w_ult_help_update from window
end type
type st_1 from statictext within w_ult_help_update
end type
type cb_5 from commandbutton within w_ult_help_update
end type
type cb_2 from commandbutton within w_ult_help_update
end type
type st_max from statictext within w_ult_help_update
end type
type sle_1 from singlelineedit within w_ult_help_update
end type
type cb_10 from commandbutton within w_ult_help_update
end type
type cb_run from commandbutton within w_ult_help_update
end type
type dw_new from datawindow within w_ult_help_update
end type
type dw_1 from datawindow within w_ult_help_update
end type
type cb_4 from commandbutton within w_ult_help_update
end type
type cb_3 from commandbutton within w_ult_help_update
end type
end forward

global type w_ult_help_update from window
integer x = 123
integer y = 112
integer width = 2139
integer height = 1116
boolean titlebar = true
string title = "Import Help Files"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 80269524
st_1 st_1
cb_5 cb_5
cb_2 cb_2
st_max st_max
sle_1 sle_1
cb_10 cb_10
cb_run cb_run
dw_new dw_new
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
end type
global w_ult_help_update w_ult_help_update

type variables
integer il_openfor
long il_hid
end variables

on w_ult_help_update.create
this.st_1=create st_1
this.cb_5=create cb_5
this.cb_2=create cb_2
this.st_max=create st_max
this.sle_1=create sle_1
this.cb_10=create cb_10
this.cb_run=create cb_run
this.dw_new=create dw_new
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.Control[]={this.st_1,&
this.cb_5,&
this.cb_2,&
this.st_max,&
this.sle_1,&
this.cb_10,&
this.cb_run,&
this.dw_new,&
this.dw_1,&
this.cb_4,&
this.cb_3}
end on

on w_ult_help_update.destroy
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.st_max)
destroy(this.sle_1)
destroy(this.cb_10)
destroy(this.cb_run)
destroy(this.dw_new)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows

if message.stringparm = "P" then  //from the intellicred program
	//skip login
	il_openfor = 0
else
	
	SQLCA.DBMS="ODBC"
	SQLCA.DbParm="ConnectString='DSN=Intellicred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"
	
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
		//MESSAGEBOX("","LOGIN OK")
	END IF
	il_openfor = 1
	
end if


dw_1.settransobject(sqlca)
//dw_1.retrieve()


select max(help_id) into :il_hid from sys_help;
st_max.text = string(il_hid)


end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type st_1 from statictext within w_ult_help_update
integer x = 87
integer y = 24
integer width = 1353
integer height = 148
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Download the help files if you do not have them in your intellicred folder."
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_ult_help_update
integer x = 1541
integer y = 132
integer width = 526
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go to Website"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.23.2006 By: Liang QingShi
//$<reason>  GetContextService is currently unsupported. 
//$<modification> Replace GetContextService with ShellExecuteA to provide the
//$<modification> same functionality.
/*
Inet  iinet_base

GetContextService("Internet", iinet_base)

//messagebox("", "http://intellisoftgroup.com/intelliapp/apps.cfm?path=" + is_app_path )

iinet_base.HyperlinkToURL("http://www.intellisoftgroup.com/customer.html")

*/
String ls_url,ls_null
setnull(ls_null)
ls_url = "http://www.intellisoftgroup.com/customer.html"
//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
//---------------------------- APPEON END ----------------------------

end event

type cb_2 from commandbutton within w_ult_help_update
integer x = 686
integer y = 1308
integer width = 485
integer height = 68
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete All Help Files"
end type

event clicked;integer r

r = messagebox("Delete","Are you sure",question!,yesno!,2)

if r = 2 then
	return
else
	delete from sys_help;
	commit using sqlca;
end if
end event

type st_max from statictext within w_ult_help_update
integer x = 59
integer y = 472
integer width = 247
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
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_ult_help_update
integer x = 41
integer y = 232
integer width = 2025
integer height = 92
integer taborder = 10
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

type cb_10 from commandbutton within w_ult_help_update
integer x = 1541
integer y = 344
integer width = 526
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse to Import file"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "addr_new"

string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value = 1 THEN
	sle_1.text = docname
END IF
end event

type cb_run from commandbutton within w_ult_help_update
integer x = 1541
integer y = 456
integer width = 526
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import"
end type

event clicked;
long ll_rec
//long ll_prac
string filename

delete from sys_help;
commit using sqlca;

filename = sle_1.text
dw_1.ImportFile ( filename)



//dw_1.setfilter("help_id > " + string(il_hid))
//dw_1.filter()

if dw_1.rowcount() < 1 then
	messagebox("No new records","No additional help files to import")
else
	dw_1.update()
	commit using sqlca;
	messagebox("Done"," Update Completed")
end if



end event

type dw_new from datawindow within w_ult_help_update
integer x = 1595
integer y = 1380
integer width = 279
integer height = 60
integer taborder = 30
string dataobject = "d_help_impt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_ult_help_update
integer x = 37
integer y = 572
integer width = 2030
integer height = 284
integer taborder = 90
string dataobject = "d_help_impt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_ult_help_update
integer x = 2199
integer y = 108
integer width = 247
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
//dw_1.print()
end event

type cb_3 from commandbutton within w_ult_help_update
integer x = 1545
integer y = 20
integer width = 521
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

