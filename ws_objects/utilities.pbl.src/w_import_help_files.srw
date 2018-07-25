$PBExportHeader$w_import_help_files.srw
forward
global type w_import_help_files from window
end type
type st_6 from statictext within w_import_help_files
end type
type cb_5 from commandbutton within w_import_help_files
end type
type st_5 from statictext within w_import_help_files
end type
type st_4 from statictext within w_import_help_files
end type
type st_3 from statictext within w_import_help_files
end type
type st_2 from statictext within w_import_help_files
end type
type st_1 from statictext within w_import_help_files
end type
type st_progress from statictext within w_import_help_files
end type
type cb_stst from commandbutton within w_import_help_files
end type
type dw_fac from datawindow within w_import_help_files
end type
type sle_app from singlelineedit within w_import_help_files
end type
type cb_getapp from commandbutton within w_import_help_files
end type
type cb_13 from commandbutton within w_import_help_files
end type
type dw_table from datawindow within w_import_help_files
end type
type cb_10 from commandbutton within w_import_help_files
end type
type cb_3 from commandbutton within w_import_help_files
end type
type sle_1 from singlelineedit within w_import_help_files
end type
end forward

global type w_import_help_files from window
integer x = 265
integer y = 16
integer width = 2770
integer height = 2436
boolean titlebar = true
string title = "Data update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79680469
st_6 st_6
cb_5 cb_5
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_progress st_progress
cb_stst cb_stst
dw_fac dw_fac
sle_app sle_app
cb_getapp cb_getapp
cb_13 cb_13
dw_table dw_table
cb_10 cb_10
cb_3 cb_3
sle_1 sle_1
end type
global w_import_help_files w_import_help_files

type variables
string is_dwname
end variables

on w_import_help_files.create
this.st_6=create st_6
this.cb_5=create cb_5
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_progress=create st_progress
this.cb_stst=create cb_stst
this.dw_fac=create dw_fac
this.sle_app=create sle_app
this.cb_getapp=create cb_getapp
this.cb_13=create cb_13
this.dw_table=create dw_table
this.cb_10=create cb_10
this.cb_3=create cb_3
this.sle_1=create sle_1
this.Control[]={this.st_6,&
this.cb_5,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_progress,&
this.cb_stst,&
this.dw_fac,&
this.sle_app,&
this.cb_getapp,&
this.cb_13,&
this.dw_table,&
this.cb_10,&
this.cb_3,&
this.sle_1}
end on

on w_import_help_files.destroy
destroy(this.st_6)
destroy(this.cb_5)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_progress)
destroy(this.cb_stst)
destroy(this.dw_fac)
destroy(this.sle_app)
destroy(this.cb_getapp)
destroy(this.cb_13)
destroy(this.dw_table)
destroy(this.cb_10)
destroy(this.cb_3)
destroy(this.sle_1)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	//MESSAGEBOX("","LOGIN OK")
//END IF
//
// is_dwname = "None"
end event

event close;//disCONNECT USING SQLCA;
end event

type st_6 from statictext within w_import_help_files
integer x = 96
integer y = 464
integer width = 1166
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
string text = "4) SAVE the file to to your IntelliCred folder."
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_import_help_files
boolean visible = false
integer x = 91
integer y = 768
integer width = 539
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Unzip"
end type

event clicked;//Access the default Internet browser to navigate to the OIG home site 
// to download the monthly OIG LEIE update zip file

String sle_url

//run("explorer.exe /n,/e,C:\intellicred\oig\")
//run("C:\intellicred\oig\updatedleie.exe")

end event

type st_5 from statictext within w_import_help_files
integer x = 96
integer y = 880
integer width = 1591
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
string text = "6) Click Import to delete existing records and import update"
boolean focusrectangle = false
end type

type st_4 from statictext within w_import_help_files
integer x = 96
integer y = 552
integer width = 1234
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
string text = "5) Browse to and select the downloaded help file."
boolean focusrectangle = false
end type

type st_3 from statictext within w_import_help_files
integer x = 96
integer y = 380
integer width = 2350
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
string text = "3) From the download page find the Help Files download, and Click on the download link."
boolean focusrectangle = false
end type

type st_2 from statictext within w_import_help_files
integer x = 96
integer y = 244
integer width = 2555
integer height = 128
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "2) Login on the site with your customer login and password.  This was sent in the in the release notification email.  Or contact Technical support."
boolean focusrectangle = false
end type

type st_1 from statictext within w_import_help_files
integer x = 96
integer y = 148
integer width = 1659
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
string text = "1) Click Get Help Files to go to the IntelliSoft Group website.  "
boolean focusrectangle = false
end type

type st_progress from statictext within w_import_help_files
integer x = 96
integer y = 1096
integer width = 2610
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 80269524
boolean enabled = false
boolean focusrectangle = false
end type

type cb_stst from commandbutton within w_import_help_files
integer x = 96
integer y = 36
integer width = 539
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Help Files"
end type

event clicked;//Access the default Internet browser to navigate to the OIG home site 
// to download the monthly OIG LEIE update zip file

String sle_url


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.23.2006 By: Liang QingShi
//$<reason>  GetContextService is currently unsupported. 
//$<modification> Replace GetContextService with ShellExecuteA to provide the
//$<modification> same functionality.
/*
inet iinet_base // instance variable used with the "Internet" or GetUrl functions

//Line - below opens your default web browser

GetContextService("Internet", iinet_base)

//Home OIG web site below:
//iinet_base.HyperlinkToURL("http://www.oig.hhs.gov/fraud/exclusions/database.html#1") // (sle_url.text)


//Downloadable OIG site for the monthly update sanction file below:

iinet_base.HyperlinkToURL("http://www.intellisoftgroup.com/customer/customer.html")
*/
String ls_url,ls_null
setnull(ls_null)
ls_url = "http://www.intellisoftgroup.com/customer/customer.html"
//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser

//---------------------------- APPEON END ----------------------------

// NEXT set the directory where to save the downloaded file and run it to unzip the UPDATED.DBF file

//run("explorer.exe /n,/e,C:\intellicred\oig\")

//End of routine


end event

type dw_fac from datawindow within w_import_help_files
boolean visible = false
integer x = 114
integer y = 800
integer width = 1070
integer height = 96
integer taborder = 80
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type sle_app from singlelineedit within w_import_help_files
boolean visible = false
integer x = 59
integer y = 636
integer width = 1691
integer height = 92
integer taborder = 60
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

type cb_getapp from commandbutton within w_import_help_files
boolean visible = false
integer x = 1783
integer y = 640
integer width = 475
integer height = 76
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "get app prop file"
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
	sle_app.text = docname
END IF
end event

type cb_13 from commandbutton within w_import_help_files
integer x = 96
integer y = 972
integer width = 539
integer height = 84
integer taborder = 100
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
integer res
string filename

//delete from sys_help;
//commit using sqlca;

filename = sle_1.text
dw_table.settransobject(sqlca)
res = dw_table.ImportFile ( filename)
if res < 1 then
	messagebox("Error Importing records","The file could not be imported")
	return
end if


if dw_table.rowcount() < 1 then
	messagebox("No new records","No additional help files to import")
else
	st_progress.text = " Deleting existing help files"
	delete from sys_help;
	commit using sqlca;
	st_progress.text = " Importing help files"
	dw_table.update()
	commit using sqlca;
	st_progress.text = "Update Completed"
end if
//
//for i = 1 to rc
//		ll_fldid++
//		dw_table.setitem(i,"rec_id",ll_fldid)
//next
//
////Step 4 start updating the database with the new OIG records and display a message
//
//st_progress.text = (" Updating database with new OIG records,(may take a few minutes)  Please wait! ")
//c = 0
//for i = 1 to rc
//	dw_table.rowscopy(i,i,primary!,dw_copy,1000000,primary!)
//	c++
//	ac++
//	if c = 500 then
//		dw_copy.update()
//		commit using sqlca;
//		c = 0
//		dw_copy.reset()
//		st_progress.text = " Updating database with new OIG records,(may take a few minutes)  Please wait! " + string (ac)
//	end if
//	
//next
//	
//	
////if dw_table.update() < 1 then
////	st_progress.text = "Save failure.  Unable to update OIG records."
////	
////else
////	commit using sqlca;	
//	//Step 5 display the number of records imported
//	ls_string = string(rc)	
//	st_progress.text = ("Import complete. Total number of new OIG records imported = " + ls_string ) 
//	update ids set last_oig_update = today();
////end if
//
//SetPointer(oldpointer)
//
//
end event

type dw_table from datawindow within w_import_help_files
integer x = 96
integer y = 1216
integer width = 2514
integer height = 944
integer taborder = 40
string dataobject = "d_help_impt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_10 from commandbutton within w_import_help_files
integer x = 96
integer y = 648
integer width = 549
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse to Help file"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "addr_new"

string dbfname, named

integer value

value = GetFileOpenName("Select File",&
+ dbfname, named, "TXT", &
	+ "text Files (*.txt),*.txt")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value = 1 THEN
	sle_1.text = dbfname
END IF
end event

type cb_3 from commandbutton within w_import_help_files
integer x = 2185
integer y = 36
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CLOSE(PARENT)
end event

type sle_1 from singlelineedit within w_import_help_files
integer x = 96
integer y = 748
integer width = 1691
integer height = 92
integer taborder = 50
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

