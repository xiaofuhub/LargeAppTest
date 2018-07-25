$PBExportHeader$w_import_prac_photos_2013.srw
forward
global type w_import_prac_photos_2013 from window
end type
type lb_gif from listbox within w_import_prac_photos_2013
end type
type lb_jpg from listbox within w_import_prac_photos_2013
end type
type lb_bmp from listbox within w_import_prac_photos_2013
end type
type cbx_skip from checkbox within w_import_prac_photos_2013
end type
type st_imp_total from statictext within w_import_prac_photos_2013
end type
type st_6 from statictext within w_import_prac_photos_2013
end type
type st_type from statictext within w_import_prac_photos_2013
end type
type st_3 from statictext within w_import_prac_photos_2013
end type
type st_total from statictext within w_import_prac_photos_2013
end type
type st_4 from statictext within w_import_prac_photos_2013
end type
type st_cnt from statictext within w_import_prac_photos_2013
end type
type st_2 from statictext within w_import_prac_photos_2013
end type
type st_1 from statictext within w_import_prac_photos_2013
end type
type cb_2 from commandbutton within w_import_prac_photos_2013
end type
type cb_1 from commandbutton within w_import_prac_photos_2013
end type
end forward

global type w_import_prac_photos_2013 from window
integer width = 2290
integer height = 2048
boolean titlebar = true
string title = "Import Photos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
lb_gif lb_gif
lb_jpg lb_jpg
lb_bmp lb_bmp
cbx_skip cbx_skip
st_imp_total st_imp_total
st_6 st_6
st_type st_type
st_3 st_3
st_total st_total
st_4 st_4
st_cnt st_cnt
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_import_prac_photos_2013 w_import_prac_photos_2013

type variables
string is_picpath
long il_openfor
end variables

on w_import_prac_photos_2013.create
this.lb_gif=create lb_gif
this.lb_jpg=create lb_jpg
this.lb_bmp=create lb_bmp
this.cbx_skip=create cbx_skip
this.st_imp_total=create st_imp_total
this.st_6=create st_6
this.st_type=create st_type
this.st_3=create st_3
this.st_total=create st_total
this.st_4=create st_4
this.st_cnt=create st_cnt
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.lb_gif,&
this.lb_jpg,&
this.lb_bmp,&
this.cbx_skip,&
this.st_imp_total,&
this.st_6,&
this.st_type,&
this.st_3,&
this.st_total,&
this.st_4,&
this.st_cnt,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1}
end on

on w_import_prac_photos_2013.destroy
destroy(this.lb_gif)
destroy(this.lb_jpg)
destroy(this.lb_bmp)
destroy(this.cbx_skip)
destroy(this.st_imp_total)
destroy(this.st_6)
destroy(this.st_type)
destroy(this.st_3)
destroy(this.st_total)
destroy(this.st_4)
destroy(this.st_cnt)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//copied and modified maha 04.29.2013
long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows
string ls_PicPath

if message.stringparm = "P" then  //from the intellicred program
	//skip login
	il_openfor = 0
else
	
	SQLCA.DBMS="ODBC"
	SQLCA.DbParm="ConnectString='DSN=Iapp;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"
	

	CONNECT USING SQLCA;
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Not Logged In", "Login Failed!")
	ELSE
		//MESSAGEBOX("","LOGIN OK")
	END IF
	il_openfor = 1
	
end if


ls_PicPath = TRIM(gnv_data.of_getitem("ids","picture_path",false))
if RightA(ls_PicPath,1) <> "\" then ls_PicPath += "\"
is_picpath = ls_picpath

lb_bmp.DirList ( ls_picpath + "*.bmp",0)
lb_jpg.DirList ( ls_picpath + "*.jpg",0)
lb_gif.DirList ( ls_picpath + "*.gif",0)
end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type lb_gif from listbox within w_import_prac_photos_2013
integer x = 1513
integer y = 156
integer width = 690
integer height = 1168
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type lb_jpg from listbox within w_import_prac_photos_2013
integer x = 777
integer y = 156
integer width = 718
integer height = 1168
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type lb_bmp from listbox within w_import_prac_photos_2013
integer x = 41
integer y = 156
integer width = 713
integer height = 1168
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cbx_skip from checkbox within w_import_prac_photos_2013
integer x = 73
integer y = 28
integer width = 1042
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Skip Previously imported files. "
end type

type st_imp_total from statictext within w_import_prac_photos_2013
integer x = 635
integer y = 1728
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "None"
boolean focusrectangle = false
end type

type st_6 from statictext within w_import_prac_photos_2013
integer x = 155
integer y = 1728
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Total Imported:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_type from statictext within w_import_prac_photos_2013
integer x = 649
integer y = 1608
integer width = 247
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "BMP"
boolean focusrectangle = false
end type

type st_3 from statictext within w_import_prac_photos_2013
integer x = 187
integer y = 1604
integer width = 443
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Importing Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_total from statictext within w_import_prac_photos_2013
integer x = 869
integer y = 1476
integer width = 247
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_import_prac_photos_2013
integer x = 768
integer y = 1476
integer width = 91
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "of"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_cnt from statictext within w_import_prac_photos_2013
integer x = 535
integer y = 1476
integer width = 206
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_import_prac_photos_2013
integer x = 197
integer y = 1476
integer width = 265
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Importing"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_import_prac_photos_2013
integer x = 1147
integer y = 1476
integer width = 667
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Provider photos found."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_import_prac_photos_2013
integer x = 1787
integer y = 20
integer width = 343
integer height = 92
integer taborder = 10
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

type cb_1 from commandbutton within w_import_prac_photos_2013
integer x = 1408
integer y = 20
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import"
end type

event clicked;//------------------------------------------------------------------------------
// Description: Upload picture to database
// Arguments:
//		None
// Return Value: 
//		None
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-07-10
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

long		ll_Cycle,ll_Cnts,ll_Prefix,ll_ExistInBasic,ll_ExistInPhoto,ll_FileNo,ll_ReadCnts,ll_Rtn, ll_total
String	ls_PicPath,ls_PicName,ls_AllPic[],ls_Prefix,ls_Postfix
BLOB		lblb_ImageData,lblb_Buffer
datetime ldt_today

CONSTANT STRING SEPCHAR = "*"

//n_cst_filesrvwin32 inv_filesrv
//n_cst_dirattrib	 inv_DirAttribBMP[],inv_DirAttribJPG[],inv_DirAttribGIF[]
//
//ls_PicPath = TRIM(gnv_data.of_getitem("ids","picture_path",false))
//if RightA(ls_PicPath,1) <> "\" then ls_PicPath += "\"
//
//ll_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,"This utility is ready to upload the photo files from the ~"" + ls_PicPath + "~" folder to the database.~r~n~r~nDo you want to continue?",Question!,YesNo!,2)
//if ll_Rtn <> 1 then Return

SetPointer(HourGlass!)

gi_yield = 0
open(w_yield)
//f_SetFileSrv(inv_filesrv,TRUE)

//inv_filesrv.of_DirList(ls_PicPath + "*.bmp",0,inv_DirAttribBMP)
//inv_filesrv.of_DirList(ls_PicPath + "*.jpg",0,inv_DirAttribJPG)
//inv_filesrv.of_DirList(ls_PicPath + "*.gif",0,inv_DirAttribGIF)

ls_Prefix = SEPCHAR

//ll_total = UpperBound(inv_DirAttribBMP) + UpperBound(inv_DirAttribJPG) + UpperBound(inv_DirAttribGIF)

ll_Cnts = lb_bmp.totalitems()

for ll_Cycle = 1 to ll_Cnts
	st_type.text = "BMP"
	ls_PicName = lb_bmp.text(ll_cycle)
	if Pos(ls_Prefix,SEPCHAR + Left(ls_PicName,LastPos(ls_PicName,".") - 1) + SEPCHAR) > 0 then CONTINUE
	ls_Prefix += LeftA(ls_PicName,LastPos(ls_PicName,".") - 1) + SEPCHAR
	ls_AllPic[UpperBound(ls_AllPic) + 1] = ls_PicName
next

ll_Cnts = lb_jpg.totalitems()

for ll_Cycle = 1 to ll_Cnts
	st_type.text = "JPG"
	ls_PicName = lb_jpg.text(ll_cycle)
	if PosA(ls_Prefix,SEPCHAR + LeftA(ls_PicName,LastPos(ls_PicName,".") - 1) + SEPCHAR) > 0 then CONTINUE
	
	ls_Prefix += LeftA(ls_PicName,LastPos(ls_PicName,".") - 1) + SEPCHAR
	ls_AllPic[UpperBound(ls_AllPic) + 1] = ls_PicName
next

ll_Cnts = lb_gif.totalitems()

for ll_Cycle = 1 to ll_Cnts
	st_type.text = "GIF"
	ls_PicName =  lb_gif.text(ll_cycle)
	if PosA(ls_Prefix,SEPCHAR + LeftA(ls_PicName,LastPos(ls_PicName,".") - 1) + SEPCHAR) > 0 then CONTINUE
	
	//ls_Prefix += Left(ls_PicName,LastPos(ls_PicName,".") - 1) + SEPCHAR
	ls_AllPic[UpperBound(ls_AllPic) + 1] = ls_PicName
next


ll_Cnts = UpperBound(ls_AllPic)
st_total.text = string(ll_cnts)
ll_total = 0


for ll_Cycle = 1 to ll_Cnts
	yield()
	if gi_yield = 1 then return
	
	st_cnt.text = string(ll_cycle)
	ls_PicName = ls_AllPic[ll_Cycle]
	ls_Prefix = LeftA(ls_PicName,LastPos(ls_PicName,".") - 1)
	ls_Postfix = MidA(ls_PicName,LastPos(ls_PicName,".") + 1)
	if IsNumber(ls_Prefix) then
		ll_Prefix = long(ls_Prefix)
		SELECT Count(*) INTO :ll_ExistInBasic from pd_basic WHERE pd_basic.prac_id = :ll_Prefix ;
		if ll_ExistInBasic <= 0 then CONTINUE
		
		SELECT Count(*) INTO :ll_ExistInPhoto from pd_photo WHERE pd_photo.prac_id = :ll_Prefix ;
		if ll_ExistInPhoto <= 0 then			
			//---------Begin Modifieded by (Appeon)Stephen 11.10.2014 for add an upload date and time to pd_photo--------
			//INSERT INTO pd_photo(prac_id,image_type) VALUES(:ll_Prefix,:ls_Postfix) ;
			ldt_today = datetime(today(),now())
			INSERT INTO pd_photo(prac_id,image_type, create_date, create_user) VALUES(:ll_Prefix,:ls_Postfix, :ldt_today, :gs_user_id) ;
			//--------End Modified----------------------
		else //maha 031609
			if cbx_skip.checked then continue
		end if
		
		ll_FileNo = FileOpen(ls_PicPath + ls_PicName,StreamMode!,Read!)
		if ll_FileNo <= 0 then CONTINUE
		
		lblb_ImageData = Blob("",EncodingAnsi!) //Encoding – Nova 11.16.2010				//Reset lblb_ImageData
		ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
		do while ll_ReadCnts > 0
			lblb_ImageData += lblb_Buffer
			ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
		loop
		
		FileClose(ll_FileNo)
		//---------Begin Modifieded by (Appeon)Stephen 11.10.2014 for add an upload date and time to pd_photo--------
		//UPDATE pd_photo SET image_type = :ls_Postfix WHERE pd_photo.prac_id = :ll_Prefix ;
		if ll_ExistInPhoto <= 0 then
			UPDATE pd_photo SET image_type = :ls_Postfix WHERE pd_photo.prac_id = :ll_Prefix ;
		else
			ldt_today = datetime(today(),now())
			UPDATE pd_photo SET image_type = :ls_Postfix, mod_date = :ldt_today, mod_user = :gs_user_id WHERE pd_photo.prac_id = :ll_Prefix ;
		end if
		//-------End Modified---------------------------		
		
		UPDATEBLOB pd_photo SET image_data = :lblb_ImageData WHERE pd_photo.prac_id = :ll_Prefix ;
		ll_total++
		st_imp_total.text = string(ll_total)
	end if
next

//f_SetFileSrv(inv_filesrv,false)
close(w_yield)
MessageBox(gnv_app.iapp_object.DisplayName,"Upload is complete!")

SetPointer(Arrow!)

end event

