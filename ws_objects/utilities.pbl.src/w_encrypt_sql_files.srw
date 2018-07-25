$PBExportHeader$w_encrypt_sql_files.srw
forward
global type w_encrypt_sql_files from window
end type
type lb_2 from listbox within w_encrypt_sql_files
end type
type lb_1 from listbox within w_encrypt_sql_files
end type
type cb_quit from commandbutton within w_encrypt_sql_files
end type
type cb_encrypt from commandbutton within w_encrypt_sql_files
end type
type cb_unencrypt from commandbutton within w_encrypt_sql_files
end type
type cb_browse from commandbutton within w_encrypt_sql_files
end type
type sle_path from singlelineedit within w_encrypt_sql_files
end type
end forward

global type w_encrypt_sql_files from window
integer width = 1929
integer height = 416
boolean titlebar = true
string title = "Encrypt /Unencrypt SQL Files"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Form!"
boolean center = true
lb_2 lb_2
lb_1 lb_1
cb_quit cb_quit
cb_encrypt cb_encrypt
cb_unencrypt cb_unencrypt
cb_browse cb_browse
sle_path sle_path
end type
global w_encrypt_sql_files w_encrypt_sql_files

type prototypes
Function Ulong GetWindowsDirectoryA(ref string path,ulong bufer) Library "kernel32.dll" alias for "GetWindowsDirectoryA;Ansi"
end prototypes

type variables
boolean ib_now
n_cst_filesrvwin32 iuo_files

str_encry Is_str[],emp_str[]
end variables

forward prototypes
public function integer of_readfilesql (string as_sqlpath)
end prototypes

public function integer of_readfilesql (string as_sqlpath);//==============================APPEON BEGIN==========================
// Event: w_vsspbg_pbpbl_bcak.of_readfilesql()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_sqlpath   sqlfile source root	
//--------------------------------------------------------------------
// Returns:  integer ;sqlfilecount
//--------------------------------------------------------------------
// Author:	Nova		Date: 12 11,2007
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================
Int i,j,k,m
String Path_Arr[],Path,Str
Long ll_count = 0
i = 1
Path_Arr[1] = as_sqlpath
Is_str = emp_str
DO WHILE i > 0
	Path = Path_Arr[i]
	i --
	lb_2.DirList(Path+'*.sql',0+1+2+4)
	FOR m = 1 To lb_2.TotalItems()
		ll_count = UpperBound(Is_str) + 1
		Is_str[ll_count].sqlfilename = lb_2.Text(m)
		Is_str[ll_count].sqlfilepath = Path
	NEXT
	lb_1.DirList(Path+'*.zzzzzzzzzz',16)
	FOR j = 2 To lb_1.TotalItems()
		Str = lb_1.Text(j)
		k = LenA(Str)
		Str = MidA(Str,2,k -2)
		i++
		Path_Arr[i] = Path+Str+'\'
	NEXT
LOOP
IF AppeonGetClientType() = 'PB' THEN
	ChangeDirectory(Gs_Current_Directory)
END IF
RETURN UpperBound(Is_str)


end function

on w_encrypt_sql_files.create
this.lb_2=create lb_2
this.lb_1=create lb_1
this.cb_quit=create cb_quit
this.cb_encrypt=create cb_encrypt
this.cb_unencrypt=create cb_unencrypt
this.cb_browse=create cb_browse
this.sle_path=create sle_path
this.Control[]={this.lb_2,&
this.lb_1,&
this.cb_quit,&
this.cb_encrypt,&
this.cb_unencrypt,&
this.cb_browse,&
this.sle_path}
end on

on w_encrypt_sql_files.destroy
destroy(this.lb_2)
destroy(this.lb_1)
destroy(this.cb_quit)
destroy(this.cb_encrypt)
destroy(this.cb_unencrypt)
destroy(this.cb_browse)
destroy(this.sle_path)
end on

event open;iuo_Files = create n_cst_filesrvwin32


end event

event close;if isvalid(iuo_Files) then destroy iuo_files
end event

type lb_2 from listbox within w_encrypt_sql_files
boolean visible = false
integer x = 1198
integer y = 140
integer width = 571
integer height = 1452
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type lb_1 from listbox within w_encrypt_sql_files
boolean visible = false
integer x = 174
integer y = 144
integer width = 896
integer height = 1468
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event constructor;// //lb_1.DirList('D:\local workspace\db_update\Update Files\'+"*.*",0+1+2+4+8+16)
// 
// Int i,j,k
//String Path_Arr[],Path,Str
//String fName //fNameÖÐ´æ·ÅÒª²éÕÒµÄÎÄ¼þÃû³Æ
//
//i=1
//Path_Arr[1]='D:\local workspace\db_update\Update Files\*.sql' //ÀýÈç,d:\oracle\,×¢Òâ×îºóµÄ\²»ÄÜÉÙ
//Do While i>0 
//Path=Path_Arr[i]
//i --
//
//lb_1.DirList(Path,0+1+2+4+8+16) //ÕÒ³öÄ¿Â¼ÏÂµÄËùÓÐÎÄ¼þ
//For j=1 To lb_1.TotalItems() 
//If Lower(lb_1.Text(j))<>Lower(fName) Then Continue
//
//MessageBox('','ÎÄ¼þ'+fName+'Î»ÓÚÄ¿Â¼'+Path+'ÏÂ');
//Exit
//Next
//
//lb_1.DirList(Path+'*.zzzzzzzzzz',16) //ÕÒ³öÄ¿Â¼ÏÂµÄËùÓÐ×ÓÄ¿Â¼
//For j=2 To lb_1.TotalItems() 
//Str=lb_1.Text(j)
//k=Len(Str)
//Str=Mid(Str,2,k -2)
//
//i++
//Path_Arr[i]=Path+Str+'\'
//messagebox("",Path_Arr[i])
//Next 
//Loop
//
end event

type cb_quit from commandbutton within w_encrypt_sql_files
integer x = 1234
integer y = 208
integer width = 384
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "ËÎÌå"
string text = "Close(&C)"
end type

event clicked;Close(Parent)


end event

type cb_encrypt from commandbutton within w_encrypt_sql_files
integer x = 439
integer y = 208
integer width = 384
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "ËÎÌå"
string text = "Encrypt(&E)"
end type

event clicked;//read sql file
String ls_rootpath = '',ls_encry
Long ll_return,li_i,ll_ret
Boolean lb_readonly,lb_hidden,lb_system,ls_subdirectory,ls_archive
String ls_path
String ls_file
String ls_outpath
IF LenA(Trim(sle_path.Text)) > 0 THEN
	ls_rootpath = Trim(sle_path.Text)+'\'
ELSE
	MessageBox("Failed","Please specify the location of the files that need to be encrypted!")
	RETURN
END IF

IF DirectoryExists(ls_rootpath) = True THEN
	ll_return = of_readfilesql(ls_rootpath)
ELSE
	MessageBox("Failed","The location that you specified does not exist.")
	RETURN
END IF
//get filename and filepath from struct array
IF ll_return > 0 THEN
	SetPointer(HourGlass!)
	IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
	IF IsValid(w_infodisp) THEN
		w_infodisp.Title = 'Encrypt SQL, Please stand by'
		w_infodisp.Center = True
		w_infodisp.st_complete.Visible = False
		w_infodisp.st_3.Visible = False
		w_infodisp.st_information.Visible = False
		w_infodisp.st_1.Text = 'Encrypt SQL, Please stand by'
		w_infodisp.wf_set_min_max(1,ll_return)
	END IF
	FOR li_i = 1 To ll_return
		IF IsValid(w_infodisp) THEN
			w_infodisp.st_1.Text = "Failed:"+ Is_str[li_i].sqlfilename+" ("+ String(li_i) +" of " +String(ll_return) +")"
		END IF
		w_infodisp.wf_step_pbar(1)
		ls_encry = Is_str[li_i].sqlfilepath
		IF iuo_files.of_GetFileAttributes (Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename,lb_readonly, lb_hidden, lb_hidden,lb_hidden, lb_hidden ) = 1 THEN
			IF lb_readonly THEN
				IF iuo_files.of_SetFileAttributes (Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename,Not lb_readonly, False, False,False) = 1 THEN
					MessageBox("Failed","Error accessing " + Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename)
					RETURN
				END IF
			END IF
		END IF
		//encrypt
		//-2:Read Error
		//-1:Write Error
		//0:no process
		//1:Successful
		ls_path = MidA(ls_encry,1,LenA(ls_encry) - 1)
		ls_file = Is_str[li_i].sqlfilename
		ls_outpath = MidA(Is_str[li_i].sqlfilepath,1,LenA(Is_str[li_i].sqlfilepath) - 1)
		ll_ret = gnv_appeondll.EncryptSql(ls_path,ls_file,ls_outpath,True)
		IF ll_ret = 0 THEN
			MessageBox("Failed","Files under the specified location have already been encrypted .")
		ELSEIF ll_ret = -2  THEN
			MessageBox("Failed","Error in accessing the update file: " + Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename)
		ELSEIF ll_ret = -1  THEN
			MessageBox("Failed","Error in writing the update file:  " + Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename)
		ELSEIF ll_ret = 1 THEN
		END IF
	NEXT
ELSE //no sql file
	MessageBox("Failed","No files under the specified location that need to be encrypted!")
	RETURN
END IF
IF IsValid(w_infodisp) THEN
	Close(w_infodisp)
END IF
SetPointer(arrow!)
MessageBox("Information:","Files under the specified location are successfully encrypted ")
ChangeDirectory (gs_current_path )






















end event

type cb_unencrypt from commandbutton within w_encrypt_sql_files
integer x = 837
integer y = 208
integer width = 384
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "ËÎÌå"
string text = "Unencrypt(&U)"
end type

event clicked;//read sql file
String ls_rootpath = '',ls_encry
Long ll_return,li_i,ll_ret
Boolean lb_readonly,lb_hidden,lb_system,ls_subdirectory,ls_archive
String ls_path
String ls_file
String ls_outpath
IF LenA(Trim(sle_path.Text)) > 0 THEN
	ls_rootpath = Trim(sle_path.Text)+'\'
ELSE
	MessageBox("Failed","Please specify the location of the files that need to be decrypted.")
	RETURN
END IF
IF DirectoryExists(ls_rootpath) = True THEN
	ll_return = of_readfilesql(ls_rootpath)
ELSE
	MessageBox("Failed","The location that you specified does not exist.")
	RETURN
END IF
//get filename and filepath from struct array
IF ll_return > 0 THEN
	SetPointer(HourGlass!)
	IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
	IF IsValid(w_infodisp) THEN
		w_infodisp.Title = 'Unencrypt SQL, Please stand by'
		w_infodisp.Center = True
		w_infodisp.st_complete.Visible = False
		w_infodisp.st_3.Visible = False
		w_infodisp.st_information.Visible = False
		w_infodisp.st_1.Text = 'Unencrypt SQL, Please stand by'
		w_infodisp.wf_set_min_max(1,ll_return)
	END IF
	FOR li_i = 1 To ll_return
		IF IsValid(w_infodisp) THEN
			w_infodisp.st_1.Text = "Current Unencrypt:"+ Is_str[li_i].sqlfilename+" ("+ String(li_i) +" of " +String(ll_return) +")"
		END IF
		w_infodisp.wf_step_pbar(1)
		ls_encry = Is_str[li_i].sqlfilepath //+ '\encry'
		//get file Attributes
		IF iuo_files.of_GetFileAttributes (Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename,lb_readonly, lb_hidden, lb_hidden,lb_hidden, lb_hidden ) = 1 THEN
			IF lb_readonly THEN
				IF iuo_files.of_SetFileAttributes (Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename,Not lb_readonly, False, False,False) <> 1 THEN
					MessageBox("Failed","Error accessing " + Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename)
					RETURN
				END IF
			END IF
		END IF
		//encrypt
		//-2:Read Error
		//-1:Write Error
		//0:no process
		//1:Successful
		//
		ls_path = MidA(ls_encry,1,LenA(ls_encry) - 1)
		ls_file = Is_str[li_i].sqlfilename
		ls_outpath = MidA(Is_str[li_i].sqlfilepath,1,LenA(Is_str[li_i].sqlfilepath) - 1)
		ll_ret = gnv_appeondll.EncryptSql(ls_path,ls_file,ls_outpath,False)
		IF ll_ret = 0 THEN
			MessageBox("Failed","Files under the specified location have already been decrypted.")
		ELSEIF ll_ret = -2  THEN
			MessageBox("Failed","Error in accessing the update file: " + Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename)
		ELSEIF ll_ret = -1  THEN
			MessageBox("Failed","Error in writing the update file: " + Is_str[li_i].sqlfilepath+Is_str[li_i].sqlfilename)
		ELSEIF ll_ret = 1 THEN
			
		END IF
	NEXT
ELSE //no sql file
	MessageBox("Failed","No files under the specified location that need to be encrypted or decrypted.")
	RETURN
END IF
IF IsValid(w_infodisp) THEN
	Close(w_infodisp)
END IF
SetPointer(arrow!)
MessageBox("Information:","Files under the specified location are successfully decrypted.")
ChangeDirectory (gs_current_path )
















end event

type cb_browse from commandbutton within w_encrypt_sql_files
integer x = 1650
integer y = 48
integer width = 247
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse..."
end type

event clicked;String ls_path
Integer li_result
li_result = GetFolder( "Sql file folder:", ls_path )

sle_path.Text = ls_path
IF AppeonGetClientType() = 'PB' THEN
	ChangeDirectory(Gs_Current_Directory)
END IF

end event

type sle_path from singlelineedit within w_encrypt_sql_files
integer y = 52
integer width = 1655
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

