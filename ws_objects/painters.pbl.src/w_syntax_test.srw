$PBExportHeader$w_syntax_test.srw
forward
global type w_syntax_test from window
end type
type cb_3 from commandbutton within w_syntax_test
end type
type sle_1 from singlelineedit within w_syntax_test
end type
type cb_2 from commandbutton within w_syntax_test
end type
type cb_1 from commandbutton within w_syntax_test
end type
end forward

global type w_syntax_test from window
integer width = 2025
integer height = 552
boolean titlebar = true
string title = "Test syntax"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
end type
global w_syntax_test w_syntax_test

type variables
string is_syntax
end variables

on w_syntax_test.create
this.cb_3=create cb_3
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.sle_1,&
this.cb_2,&
this.cb_1}
end on

on w_syntax_test.destroy
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_syntax_test
integer x = 1481
integer y = 232
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type sle_1 from singlelineedit within w_syntax_test
integer x = 114
integer y = 92
integer width = 1330
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_syntax_test
integer x = 795
integer y = 224
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test Syntax"
end type

event clicked;ulong l_handle
integer li_filenum, li_loops, li_counter 
long ll_filelen, ll_bytes_read, ll_new_pos 
long ll_cnt
blob lb_our_blob, lb_tot_b, blob_temp, total_blob, blank_blob 
String ls_sql
string ls_file
string ls_temp
Long		fh
Integer li_retval
blob		lb_image
integer j
string errorBuffer

ls_file = sle_1.text
if not fileexists(ls_file) then
	messagebox(ls_file,"No file")
	return
end if

ll_filelen = FileLength( ls_file ) 
//messagebox("", ll_filelen)
IF ll_filelen = -1 THEN
	MessageBox("Error", "Error with FileLength command. ." )
	Return 
END IF

li_filenum = FileOpen( ls_file , StreamMode!,READ!,LOCKREAD!)


IF li_filenum <> -1 THEN
	
	//Find out how long the file specified in sle_filename.text is

	//Determine how many FileReads will be necessary to read all of the file ... 
	//You can't read in more than 32K at a time 
	IF ll_filelen > 32765 THEN 
   	 IF Mod(ll_filelen,32765) = 0 THEN 
	        li_loops = ll_filelen/32765 
	    ELSE 
   	     li_loops = (ll_filelen/32765) + 1 
	    END IF 
	ELSE 
   	 li_loops = 1 
	END IF 

	//read the file ... 
	FOR li_counter = 1 to li_loops 
   		 ll_bytes_read = FileRead( li_filenum, ls_temp) 
		 IF ll_bytes_read = -1 THEN
			MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return
		 END IF
		ls_sql = ls_sql + ls_temp
//	    lb_tot_b = lb_tot_b + blob_temp 
//   	 ll_new_pos = ll_new_pos + ll_bytes_read 
//	    FileSeek(li_filenum, ll_new_pos, FROMBEGINNING!) 
//
//   	 if len(lb_tot_b) > 1000000 then 
//	        total_blob = total_blob + lb_tot_b 
//   	     lb_tot_b = blank_blob 
//	    end if 
	NEXT 

//	total_blob = total_blob + lb_tot_b 

//	lb_image = total_blob
	
	//messagebox("len", len( lb_image ))

	FileClose(li_filenum) 
	
	//li_retval = FileRead(li_filenum, lb_image)
	//IF li_retval = -1 THEN
	//	MessageBox("File Read Error", "Could not read file" )
	//	Return -1
	//END IF
	//FileClose(li_filenum)
	is_syntax = ls_sql
	
	openwithparm(w_sql_msg,is_syntax)
	


//	of_library_check( gs_dir_path + "intellicred\report_temp.pbd") 
	j = LibraryImport( gs_dir_path + "intellicred\report_temp.pbd","syntax_test", ImportDataWindow!, is_syntax, ErrorBuffer)
		messagebox(string(j),gs_dir_path + "intellicred\report_temp.pbd")
		if LenA(ErrorBuffer ) > 1 then
			messagebox("Syntax error during LibraryImport", errorBuffer)
		end if

END IF







end event

type cb_1 from commandbutton within w_syntax_test
integer x = 1477
integer y = 88
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse"
end type

event clicked;string filename
string path

//---------Begin Modified by (Appeon)Stephen 02.17.2014 for file paths modify --------
//GetFileOpenName ( "Select File", path, filename, "ISG", "ISG Files (*.isg),*.isg" , "C:\intellicred\")
GetFileOpenName ( "Select File", path, filename, "ISG", "ISG Files (*.isg),*.isg" , gs_dir_path + gs_DefDirName+"\")
//---------End Modfiied ------------------------------------------------------
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
sle_1.text = filename
end event

